# JIBUC

A compiler for jibuc [programs](documentation/PROJECT_SPECIFICATION.pdf), a syntatical limited language
for the purposes of storing and manipulating integers with interactive capabilities.

## Basic Usage

### Compilation

```
cd build/
```

```
flex ../src/JIBUC.l
```

```
g++ lex.yy.cc -o JIBUC
```

### Running Lexical Analysis

lexical Analysis can be ran using the 'JIBUC' binary. This will parse the program piped to JIBUC,
printing tokens and their type as well as highligthing invalid tokens present in the program.

Example programs can be found in the `./example-programs` folder.

Example Usage:

```
./build/JIBUC < example-programs/sample-invalid-program.jibuc
```

## Dependencies

Supported Opereating System (OS): 
    - Arch Linux
    - Red Hat Linux

Packages:
    - Flex
    - Bison

Language:
    - C++
