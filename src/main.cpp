#include "FlexLexer.h"
#include <vector>
#include "Token.h"

int main() {

    yyFlexLexer lexer;
    Token currentToken;

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
