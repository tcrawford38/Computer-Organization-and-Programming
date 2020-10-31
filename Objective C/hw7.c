/**
 * @file hw7.c
 * @author Thomas Crawford
 * @brief Command-line argument & expression parsing logic
 * @date 2020-03-xx
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include <stdio.h>
#include "hw7.h"
#include "errcodes.h"

#define FALSE 0
#define TRUE 1

// One-time defined global array of expressions
struct expression arr[MAX_NUMBER_OF_EXPRESSIONS];

/**
 * @brief Convert a string containing ASCII characters (in decimal) to an int.
 * 
 * @param str A null-terminated C string
 * @return int the corresponding decimal value of the passed in str
 */
int decimalStringToInt(const char *str)
{
    //UNUSED_PARAM(str);
    int newInt = 0;
    int power = 1;
    int length = 0;
    while ((*str != 43) && (*str != 45) && (*str != 00)) {
        str++;
        length++;
    }
    for (int i = length; i > 0; i--) {
            str--;
            newInt += power * (*str - 48);
            power *= 10;
        }
    return newInt;
}

/**
 * @brief Convert a string containing ASCII characters (in hex) to an int.
 * 
 * @param str A null-terminated C string
 * @return int the corresponding decimal value of the passed in hexadecimal str
 */
int hexStringToInt(const char *str)
{
    //UNUSED_PARAM(str);
    int newInt = 0;
    int power = 1;
    int length = 0;
    while ((*str != 43) && (*str != 45) && (*str != 00)) {
        str++;
        length++;
    }
    for (int i = length; i > 0; i--) {
        str--;
        if (*str >= 65) {
            newInt += power * (*str - 55);
        } else {
            newInt += power * (*str - 48);
        }
        power *= 16;
    }
    return newInt;
}

/**
 * @brief Parser algorithm for determining the result of a basic math expression.
 * 
 * @param expression A null terminated expression retrieved as a command line arg
 * @param index Indicating the corresponding struct in the global struct array (for this expression) to be populated
 */
void parseExpression(char *expression, int index)
{
    //UNUSED_PARAM(expression);
    //UNUSED_PARAM(index);
    // If operation is 1, then add. If operation is 0, then subtract
    int operation = 1;
    int result = 0;
    char *buff;
    char *tempt = expression;
    int errorCode = NO_ERROR;
    while (*expression != 00) {
        if ((*expression <= 57) && (*expression > 48)) {
            if (operation == 1) {
                result = result + decimalStringToInt(expression);
                while ((*expression != 43) && (*expression != 45)
                    && (*expression != 00)) {
                    expression++;
                }
            } else {
                result = result - decimalStringToInt(expression);
                while ((*expression != 43) && (*expression != 45)
                    && (*expression != 00)) {
                    expression++;
                }
            }
        } else if (*expression == 48) {
            if (*(expression + 1) == 120) {
                expression++;
                if ((*(expression + 1) >= 48 && *(expression + 1) <= 57)
                    || (*(expression + 1) >= 65 && *(expression + 1) <= 70)) {
                    expression++;
                    if (operation == 1) {
                        result = result + hexStringToInt(expression);
                        while ((*(expression + 1) >= 48 && *(expression + 1) <= 57) 
                            || (*(expression + 1) >= 65 && *(expression + 1) <= 70)) {
                            expression++;
                        }
                        expression++;
                        if ((*expression != 43) && (*expression != 45)
                            && (*expression != 00)) {
                            buff = ERROR_MSG;
                            result = 0;
                            errorCode = ERR_MALFORMED_HEX_FOUND;
                            break;
                        }
                    } else {
                        result = result - hexStringToInt(expression);
                        while ((*(expression + 1) >= 48 && *(expression + 1) <= 57)
                            || (*(expression + 1) >= 65 && *(expression + 1) <= 70)) {
                            expression++;
                        }
                        expression++;
                        if ((*expression != 43) && (*expression != 45)
                            && (*expression != 00)) {
                            buff = ERROR_MSG;
                            result = 0;
                            errorCode = ERR_MALFORMED_HEX_FOUND;
                            break;
                        }
                    }
                } else {
                buff = ERROR_MSG;
                result = 0;
                errorCode = ERR_MALFORMED_HEX_FOUND;
                break;
                }
            } else {
                expression++;
            }
        } else if (*expression == 43) {
            operation = 1;
            expression++;
        } else if (*expression == 45) {
            operation = 0;
            expression++;
        } else {
            buff = ERROR_MSG;
            result = 0;
            errorCode = ERR_MALFORMED_HEX_FOUND;
            break;
        }
    }
    if (errorCode == NO_ERROR) {
        buff = tempt;
    }
    my_strncpy(arr[index].buffer, buff, my_strlen(buff));
    arr[index].result = result;
    arr[index].errorCode = errorCode;

    // TODO: Iterate through the string, parsing each sum term and adding them to a result
    
    // TODO: Initialize the struct info for this expression and write it to the struct
}

/**
 * @brief Helper method for printing out the global array struct info
 * DO NOT MODIFY THIS METHOD AS IT IS USED FOR THE LAST STEP (PIPE).
 */
void printArrayDebug(void)
{
    // Safety check
    if (sizeof(arr) / sizeof(arr[0]) != MAX_NUMBER_OF_EXPRESSIONS)
    {
        printf("ERROR: MISMATCH ARRAY LENGTH WITH MACRO: MAX_NUMBER_OF_EXPRESSIONS.\n");
        return;
    }

    for (int i = 0; i < MAX_NUMBER_OF_EXPRESSIONS; i++)
    {
        printf("\nStruct info at index %d:\n", i);
        printf("Expression: %s\n", arr[i].buffer);
        printf("Result: %d\n", arr[i].result);
        printf("ErrorCode: %u\n", arr[i].errorCode);
        printf("---------------------\n");
    }
}

/**
 * @brief Main method, responsible for parsing command line argument and populating expression structs in the global arr
 * 
 * @param argc argument count
 * @param argv argument vector (it's an array of strings)
 * @return int status code of the program termination
 */
int my_main(int argc, char const *argv[])
{
    //UNUSED_FUNC(hexStringToInt);
    //UNUSED_FUNC(parseExpression);
    //UNUSED_FUNC(printArrayDebug);
    //UNUSED_FUNC(decimalStringToInt);
    //UNUSED_PARAM(argv);
    
    // Initial check: We need at least 1 math expression passed in
    // ( Yes argc can possibly be zero! But we don't worry about that too much in this hw :) )
    if (argc < 2)
    {
        printf("USAGE:   ./hw7 [-d] \"basic math expressions separated by quotation marks\"\n");
        printf("EXAMPLE: ./hw7 \"3+0x40-7+5\" \"0xA6+5000-45\"\n");
        printf("EXAMPLE FOR PRINTING OUT DEBUG INFO: ./hw7 -d \"3+0x40-7+5\" \"0xA6+5000-45\"\n");
        return 1; // Exit failure (value is implementation defined)
    } else {
        int debugFlag = 0;
        int index = 0;
        if (((my_strncmp(argv[1], DEBUG_FLAG, 2)) == 0)) {
                debugFlag = 1;
            }
        if (argc - debugFlag > 6) {
            printf("PROGRAM ERROR: Too many expressions specified!\n");
            return 1;
        } else if (debugFlag == 1 && argc < 3) {
            printf("PROGRAM ERROR: No expression specified\n");
            return 1;
        }
        for (int i = 1; i < argc; i++) {
            if ((debugFlag == 1) && (i == 1)) {
                continue;
            }
            size_t length = my_strlen((char*)argv[i]);
            if (length > 25) {
                my_strncpy(arr[index].buffer, ERROR_MSG, my_strlen(ERROR_MSG));
                arr[index].result = 0;
                arr[index].errorCode = ERR_EXPRESSION_TOO_LONG;
                index++;
            } else if (length < 1) {
                my_strncpy(arr[index].buffer, ERROR_MSG, my_strlen(ERROR_MSG));
                arr[index].result = 0;
                arr[index].errorCode = ERR_EXPRESSION_TOO_SMALL;
                index++;
            } else {
            parseExpression((char*)argv[i], index);
            index++;
            }
        }
        if (debugFlag == 1) {
            printArrayDebug();
        }
    }

    // Note 1: If debug flag is presented in any other location besides argv[1], it should be treated as a bad HEX value

    // Note 2: In order to protect our struct array from overflow and undefined behavior,
    // we need to make sure we don't pass in more command-line arguments than necessary.
    // Later on in the course you will learn how to dynamically allocate space for situations like this!

    return 0; // EXIT_SUCCESS
}
