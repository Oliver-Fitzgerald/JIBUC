# JIBUC

A compiler for jibuc [programs](documentation/PROJECT_SPECIFICATION.pdf), a syntatical limited language
for the purposes of storing and manipulating integers with interactive capabilities.

## Basic Usage

### Compilation

```
flex ../src/JIBUC.l
```

```
g++ lex.yy.cc -o JIBUC
```

### Running Lexical Analysis

lexical Analysis can be ran using the 'JIBUC' binary with the "-l" or "--lexical" flags.
This will parse the programs at the passed file paths, printing tokens and their type as 
well as highligthing invalid tokens present in the program.

Example programs can be found in the `./example-programs` folder.

Example Usage:

```
./build/JIBUC < example-programs/sample-invalid-program.jibuc
```

## Dependencies

OS: Arch Linux or Red Hat Linux
Packages: Flex, Bison, cmake, make
Language: C++
