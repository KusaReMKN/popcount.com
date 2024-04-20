# POPCOUNT

Count the number of one bits of standard input

## How to Build

`MASM`, `LINK`, and `EXE2BIN` are required to build.  These programs are
available in binary form from [microsoft/MS-DOS].

```
MASM POPCOUNT;
LINK POPCOUNT;
EXEW2BIN POPCOUNT POPCOUNT.COM
```

## Usage

```
POPCOUNT <FILE
SOMECMD | POPCOUNT
```

The **POPCOUNT** command reads data from standard input and calculates
the number of bits set one.  The result is then displayed in octal
notation.

## Implementation Note

The **POPCOUNT** command can calculate 32-bit values.  This means that
the maximum value that can be counted correctly is 2^32 - 1 (4294967295,
37777777777 in octal).

## Exit Status

The **POPCOUNT** command exits 0 on success, and >0 if an error occurs.

[microsoft/MS-DOS]: https://github.com/microsoft/MS-DOS
