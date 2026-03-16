#ifndef Token_H
#define Token_H

// Standard
#include <string>
#include <map>

struct Token {
    int type;
    std::string value;
};

std::map<int, std::string> tokenKeys = {
    {1, "TOKEN_WHITE_SPACE"},
    {2, "TOKEN_NEWLINE"},
    {3, "TOKEN_BEGINNING"},
    {4, "TOKEN_BODY"},
    {5, "TOKEN_END"},
    {6, "TOKEN_CAPACITY"},
    {7, "TOKEN_MOVE"},
    {8, "TOKEN_TO"},
    {9, "TOKEN_ADD"},
    {10, "TOKEN_INPUT"},
    {11, "TOKEN_OUTPUT"},
    {12, "TOKEN_PRINT"},
    {13, "TOKEN_STRING_DELIMITER"},
    {14, "TOKEN_INTEGER"},
    {15, "TOKEN_IDENTIFIER"},
    {16, "TOKEN_ILLEGAL"},
    {17, "TOKEN_STRING"},
    {18, "TOKEN_DOT"}
};
#define TOKEN_WHITE_SPACE 1
#define TOKEN_NEWLINE 2
#define TOKEN_BEGINNING 3
#define TOKEN_BODY 4
#define TOKEN_END 5
#define TOKEN_CAPACITY 6
#define TOKEN_MOVE 7
#define TOKEN_TO 8
#define TOKEN_ADD 9
#define TOKEN_INPUT 10
#define TOKEN_OUTPUT 11
#define TOKEN_PRINT 12
#define TOKEN_STRING_DELIMITER 13
#define TOKEN_INTEGER 14
#define TOKEN_IDENTIFIER 15
#define TOKEN_ILLEGAL 16
#define TOKEN_STRING 17
#define TOKEN_DOT 18

#endif
