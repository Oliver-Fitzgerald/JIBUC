/*
 * JIBUC.cpp
 * The entrypoint for the JIBUC compiler
 */

// Standard
#include <vector>
#include <cstdio>
#include <iostream>
#include <fstream>
// JIBUC
#include "Token.h"
//#include "../build/lexer.h"
// CLI11
#include <CLI/CLI.hpp>

extern Token currentToken;
extern std::vector<std::string> tokens;

int yylex(); // Forward-declare Flex-generated functions
void lexicalAnalysis(std::string filePath);


int main(int argc, char** argv) {

    // Initalize CLI
    CLI::App jibuc{"A compiler for jibuc programs"};
    jibuc.require_subcommand();
    argv = jibuc.ensure_utf8(argv);

    std::string filePath;
    CLI::App* lexicalSubCommand = jibuc.add_subcommand("lexical", "Performs lexical analysis on a file");
    lexicalSubCommand->add_option("filePath", filePath, "Path to file on which lexical analysis will be performed");
    lexicalSubCommand->final_callback( [&filePath] {
        lexicalAnalysis(filePath);
    });
    

    CLI11_PARSE(jibuc, argc, argv);
    return 0;
}

void lexicalAnalysis(std::string filePath) {

    extern FILE* yyin;
    yyin = fopen(filePath.c_str(), "r");

    printf("parsing tokens to perform lexical analysis:\n\n");
    int tok; int faults = 0;

    std::vector<std::string> lineTokens;
    std::vector<std::string> lineValues;

    while ((tok = yylex()) != 0) {

        std::string tokenValue = tokens[currentToken.index];
        if (tokenValue == "TOKEN_ILLEGAL")
            faults++;
        
        lineTokens.push_back(tokenValue);
        lineValues.push_back(currentToken.value);

        if (tokenValue == "TOKEN_NEWLINE") {

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
    fclose(yyin);

}
