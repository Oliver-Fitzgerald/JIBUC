cmake_minimum_required(VERSION 3.16)
project(MyFlexCLI11App VERSION 1.0.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ──────────────────────────────────────────────
# Find Flex
# ──────────────────────────────────────────────
find_package(FLEX REQUIRED)

if(NOT FLEX_FOUND)
    message(FATAL_ERROR "Flex not found. Install flex (e.g. 'apt install flex' or 'brew install flex').")
endif()

# Generate the lexer source from the .l file
FLEX_TARGET(MyLexer
    ${CMAKE_CURRENT_SOURCE_DIR}/src/JIBUC.l
    ${CMAKE_CURRENT_BINARY_DIR}/lexer.cpp
)

# ──────────────────────────────────────────────
# CLI11 (header-only — fetch if not installed)
# ──────────────────────────────────────────────
find_package(CLI11 QUIET)

if(NOT CLI11_FOUND)
    message(STATUS "CLI11 not found locally — fetching via FetchContent")
    include(FetchContent)
    FetchContent_Declare(
        CLI11
        GIT_REPOSITORY https://github.com/CLIUtils/CLI11.git
        GIT_TAG        v2.4.2
    )
    FetchContent_MakeAvailable(CLI11)
endif()

# ──────────────────────────────────────────────
# Executable
# ──────────────────────────────────────────────
add_executable(${PROJECT_NAME}
    src/JIBUC.cpp
    ${FLEX_MyLexer_OUTPUTS}
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# No ${FLEX_LIBRARIES} — noyywrap means libfl is not needed and causes issues
target_link_libraries(${PROJECT_NAME} PRIVATE
    CLI11::CLI11
)

# ──────────────────────────────────────────────
# Suppress common Flex-generated warnings
# ──────────────────────────────────────────────
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    set_source_files_properties(${FLEX_MyLexer_OUTPUTS} PROPERTIES
        COMPILE_FLAGS "-Wno-unused-function -Wno-sign-compare -Wno-register"
    )
endif()

install(TARGETS ${PROJECT_NAME} DESTINATION bin)
