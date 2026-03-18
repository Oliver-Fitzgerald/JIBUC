%option noyywrap
%{

// Standard
#include <vector>
#include <algorithm>
#include <iostream>
// JIBUC
#include "../src/Token.h"

Token currentToken;
std::vector<std::string> tokens = {
    "TOKEN_WHITE_SPACE",
    "TOKEN_NEWLINE",
    "TOKEN_BEGINNING",
    "TOKEN_BODY",
    "TOKEN_END",
    "TOKEN_CAPACITY",
    "TOKEN_MOVE",
    "TOKEN_TO",
    "TOKEN_ADD",
    "TOKEN_INPUT",
    "TOKEN_OUTPUT",
    "TOKEN_PRINT",
    "TOKEN_STRING_DELIMITER",
    "TOKEN_INTEGER",
    "TOKEN_IDENTIFIER",
    "TOKEN_ILLEGAL",
    "TOKEN_STRING",
    "TOKEN_DOT"
};

int findIndex(std::string value);

%}

/* Punctuation */
WHITE_SPACE         [ \t]+
NEWLINE             \n
DOT                 \.
STRING_DELIMITER    ;

/* Keywords */
BEGINNING           BEGINNING|beginning
BODY                BODY|body
END                 END|end
MOVE                MOVE|move
TO                  TO|to
ADD                 ADD|add
INPUT               INPUT|input
OUTPUT              OUTPUT|output
PRINT               PRINT|print

/* Parameter Declaration */
CAPACITY            X+
STRING              \"[^\"]*\"
INTEGER             [0-9]+
IDENTIFIER          [a-zA-Z0-9\-]+

/* Other */
ILLEGAL             [^a-zA-Z0-9\-;\" \t\n]

%%

{NEWLINE}           { currentToken = {findIndex("TOKEN_NEWLINE"),           yytext}; return findIndex("TOKEN_NEWLINE"); }
{BEGINNING}         { currentToken = {findIndex("TOKEN_BEGINNING"),         yytext}; return findIndex("TOKEN_BEGINNING"); }
{BODY}              { currentToken = {findIndex("TOKEN_BODY"),              yytext}; return findIndex("TOKEN_BODY"); }
{END}               { currentToken = {findIndex("TOKEN_END"),               yytext}; return findIndex("TOKEN_END"); }
{CAPACITY}          { currentToken = {findIndex("TOKEN_CAPACITY"),          yytext}; return findIndex("TOKEN_CAPACITY"); }
{MOVE}              { currentToken = {findIndex("TOKEN_MOVE"),              yytext}; return findIndex("TOKEN_MOVE"); }
{TO}                { currentToken = {findIndex("TOKEN_TO"),                yytext}; return findIndex("TOKEN_TO"); }
{ADD}               { currentToken = {findIndex("TOKEN_ADD"),               yytext}; return findIndex("TOKEN_ADD"); }
{INPUT}             { currentToken = {findIndex("TOKEN_INPUT"),             yytext}; return findIndex("TOKEN_INPUT"); }
{OUTPUT}            { currentToken = {findIndex("TOKEN_OUTPUT"),            yytext}; return findIndex("TOKEN_OUTPUT"); }
{PRINT}             { currentToken = {findIndex("TOKEN_PRINT"),             yytext}; return findIndex("TOKEN_PRINT"); }
{STRING_DELIMITER}  { currentToken = {findIndex("TOKEN_STRING_DELIMITER"),  yytext}; return findIndex("TOKEN_STRING_DELIMITER"); }
{INTEGER}           { currentToken = {findIndex("TOKEN_INTEGER"),           yytext}; return findIndex("TOKEN_INTEGER"); }
{IDENTIFIER}        { currentToken = {findIndex("TOKEN_IDENTIFIER"),        yytext}; return findIndex("TOKEN_IDENTIFIER"); }
{STRING}            { currentToken = {findIndex("TOKEN_STRING"),            yytext}; return findIndex("TOKEN_STRING"); }
{DOT}               { currentToken = {findIndex("TOKEN_DOT"),               yytext}; return findIndex("TOKEN_DOT"); }
{ILLEGAL}           { currentToken = {findIndex("TOKEN_ILLEGAL"),           yytext}; return findIndex("TOKEN_ILLEGAL"); }

%%

int findIndex(std::string value) {

    auto itterator = std::find(tokens.begin(), tokens.end(), value);
    if (itterator != tokens.end()) {
        return std::distance(tokens.begin(), itterator);
    } else
        return -1;
}
