	NAME	POPCOUNT
	TITLE	POPCOUNT -- Count the number of one bits of standard input

BUFSIZ	EQU	512
STDERR	EQU	2
STDOUT	EQU	1

CODE	SEGMENT
	ASSUME	ES:CODE, CS:CODE, SS:CODE, DS:CODE
	ORG	0100H

START:	XOR	CX, CX
	MOV	DX, CX

NEXT:	CALL	GETCH
	MOV	BL, BYTE PTR [BX+POPTAB]
	ADD	CX, BX
	ADC	DX, +0
	JMP	SHORT NEXT

GETCH:	PUSH	CX
	PUSH	DX

	MOV	SI, BUFCUR
	CMP	SI, BUFLEN
	JNE	CURCH

	MOV	AH, 3FH
	MOV	CX, BUFSIZ
	MOV	DX, OFFSET BUFPTR
	XOR	BX, BX
	INT	21H
	JC	ERROR

	OR	AX, AX
	JZ	FINISH

	MOV	BUFLEN, AX
	XOR	SI, SI

CURCH:	XOR	BH, BH
	MOV	BL, BYTE PTR [SI+BUFPTR]
	INC	SI
	MOV	BUFCUR, SI

	POP	DX
	POP	CX
	RET

ERROR:	MOV	AH, 40H
	MOV	CX, 36
	MOV	DX, OFFSET ERRMSG
	MOV	BX, STDERR
	INT	21H

	MOV	AX, 4C01H
	INT	21H

FINISH:	POP	DX
	POP	BX

	MOV	CX, 11
	MOV	DI, OFFSET STREND
	STD

TOOCT:	MOV	AL, BL
	AND	AL, 07H
	OR	AL, 30H
	STOSB

	MOV	AH, DL

	PUSH	CX
	MOV	CL, 3
	SHR	BX, CL
	SHR	DX, CL

	MOV	CL, 5
	SHL	AH, CL
	OR	BH, AH
	POP	CX
	LOOP	TOOCT

	INC	DI
	MOV	AH, 40H
	MOV	CX, 13
	MOV	DX, DI
	MOV	BX, STDOUT
	INT	21H

	MOV	AX, 4C00H
	INT	21H

POPTAB:	DB	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4
	DB	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
	DB	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
	DB	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
	DB	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
	DB	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
	DB	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
	DB	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
	DB	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
	DB	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
	DB	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
	DB	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
	DB	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
	DB	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
	DB	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
	DB	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8

STRBUF:	DB	10 DUP (?)
STREND:	DB	?, 0DH, 0AH
ERRMSG:	DB	'Error: stdin: Something went wrong', 0DH, 0AH
BUFCUR:	DW	0
BUFLEN:	DW	0
BUFPTR:	; No need to explicitly allocate memory space
	;DB	BUFLEN	DUP (?)

CODE	ENDS
	END	START

