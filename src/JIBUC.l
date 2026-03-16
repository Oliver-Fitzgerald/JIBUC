%option c++
%option noyywrap
%{
#include <vector>
#include "../src/Token.h"
Token currentToken;
%}

WHITE_SPACE [ \t]+
NEWLINE \n

BEGINNING BEGINNING|begining
BODY BODY|body
END END|end
MOVE MOVE|move
TO TO|to
ADD ADD|add
INPUT INPUT|input
OUTPUT OUTPUT|output
PRINT PRINT|print

CAPACITY X+
DOT \.
STRING_DELIMITER ;
STRING \"[^\"]*\"
INTEGER [0-9]+
IDENTIFIER [a-zA-Z0-9\-]+
ILLEGAL [^a-zA-Z0-9\-;\" \t\n]

%%
{WHITE_SPACE} {/* Skip */}
{NEWLINE} { currentToken = {TOKEN_NEWLINE, yytext}; return TOKEN_NEWLINE;}

{BEGINNING} {currentToken = {TOKEN_BEGINNING, yytext}; return TOKEN_BEGINNING;}
{BODY} {currentToken = {TOKEN_BODY, yytext}; return TOKEN_BODY;}
{END} {currentToken = {TOKEN_END, yytext}; return TOKEN_END;}
{CAPACITY} {currentToken = {TOKEN_CAPACITY, yytext}; return TOKEN_CAPACITY;}
{MOVE} {currentToken = {TOKEN_MOVE, yytext}; return TOKEN_MOVE;}
{TO} {currentToken = {TOKEN_TO, yytext}; return TOKEN_TO;}
{ADD} {currentToken = {TOKEN_ADD, yytext}; return TOKEN_ADD;}
{INPUT} {currentToken = {TOKEN_INPUT, yytext}; return TOKEN_INPUT;}
{OUTPUT} {currentToken = {TOKEN_OUTPUT, yytext}; return TOKEN_OUTPUT;}
{PRINT} {currentToken = {TOKEN_PRINT, yytext}; return TOKEN_PRINT;}

{DOT} {currentToken = {TOKEN_DOT, yytext}; return TOKEN_DOT;}
{STRING_DELIMITER} {currentToken = {TOKEN_STRING_DELIMITER, yytext}; return TOKEN_STRING_DELIMITER;}
{STRING} {currentToken = {TOKEN_STRING, yytext}; return TOKEN_STRING;}
{INTEGER} {currentToken = {TOKEN_INTEGER, yytext}; return TOKEN_INTEGER;}
{IDENTIFIER} {currentToken = {TOKEN_IDENTIFIER, yytext}; return TOKEN_IDENTIFIER;}
{ILLEGAL} {currentToken = {TOKEN_ILLEGAL, yytext}; return TOKEN_ILLEGAL;}
%%

class MyLexer : public yyFlexLexer {
public:
    using yyFlexLexer::yyFlexLexer;  // inherit constructors

    // override yywrap for C++
    int yywrap() override {
        return 1;  // return 1 means end-of-input
    }
};

int main() {

    yyFlexLexer lexer;
    printf("parsing tokens to perform lexical analysis:\n\n");
    int tok; int faults = 0;

    std::vector<std::string> lineTokens;
    std::vector<std::string> lineValues;

    while ((tok = lexer.yylex()) != 0) {

        if (currentToken.type == 16)
            faults++;
        
        lineTokens.push_back(tokenKeys[currentToken.type]);
        lineValues.push_back(currentToken.value);

        if (currentToken.type == 2) {
            
            for (int i = 0; i < lineValues.size(); i++) {
                const std::string value = lineValues[i];
                
                if (value != "\n") {
                    std::cout << value << " ";
                    if (lineTokens[i].size() > value.size())
                        for (int j = 0; j < lineTokens[i].size() - value.size() + 1; j++) {
                            std::cout << " ";
                        }
                }
            }
            std::cout << "\n";
            for (int i = 0; i < lineTokens.size(); i++) {
                const std::string token = lineTokens[i];

                if (token == "TOKEN_ILLEGAL")
                    std::cout << "\033[31m^" << token << "\033[0m ";
                else 
                    std::cout << "\033[32m^" << token << "\033[0m ";

                if (lineValues[i].size() > token.size()) {
                    for (int j = 0; j < lineValues[i].size() - token.size() - 1; j++) {
                        std::cout << " ";
                    }
                }
            }
            std::cout << "\n\n";

            lineTokens.clear();
            lineTokens.shrink_to_fit();
            lineValues.clear();
            lineValues.shrink_to_fit();

        }
    }
    std::cout << "\n\033[31mNumber of illegal tokens\033[0m: " << faults << "\n";
    return 0;
}
