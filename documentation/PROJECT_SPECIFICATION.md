# CS4158: A Parser for JIBUC Programs

Devlop a parser and associated lexical analysis tool for a syntacticaly
limited language

## Language Syntax

The language is not case sensitive.
Programs are monolothic starting with the key word "BEGINING" and ending with the key
word "END"

Statements within the program can be categorized as:
- Declerations
- Assignments
- Inputs
- Outputs

--- 

### Declerations

--- 

Declerations are placed below the "BEGINING" key word.
Only varriables of type integer are supported

#### Capacity
In an individual decleration the first string defines capacity, where the string is formed
from one or more "X"s where the number of "X"s defines the number of digits in the number.
e.g "XXX" is a three-digit number

#### Identifier
Following the capacity will be a string identifier for the declared varriable.
identifiers can be any combination of alphatbetic charachters, digits and hyphons as long as
it starts with a charachter and is not a continuous string of Xs

--- 

### Main Program Body

--- 

After the declarations, comes the main body of code, signified by the keyword
"BODY". This body of code consists of one or more statements after this keyword.
The program ends with the "END." statement.

#### Move
The assignment statements are of either of the following forms:
- MOVE identifier TO identifier.
- MOVE integer TO identifier
Where the identifier following the "TO" keyword is the target varriable for the "MOVE" operation

#### ADD
Alternatively, an assignment statement can be of the forms:
- ADD integer TO identifier.
- ADD identifier TO identifier.

#### INPUT
The input statement is of the following form:
- INPUT identifier1; identifier2; identifier3.

This read statement above will take in 3 values which will be held in the variables
identified by identifier1, identifier 2 and identifier3. However read statements are not
just limited to taking in 3 values. They may take in any number of values required by
the program.

#### OUTPUT
The output statement is of the following form
- PRINT “I’m printed out”; identifier1.
It starts with the keyword ‘Print’ and then contains any combinations of either
identifiers or text (enclosed in quotation marks), separated by semi-colons. The print
statement above prints out the string ‘I’m printed out’, followed by whatever value is
held by identifier 1.

--- 

### Deliverables

--- 

#### Lexer
 - identifies all the tokens of the language
 - showing this by printing out the token types on recognition.

#### Parser

## Tools

Language: C++
OS: Red Hat Linux
