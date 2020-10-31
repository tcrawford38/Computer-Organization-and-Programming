/**
 * Part 2 - Coding with bases
 *
 * @author Thomas Crawford
 * @version 1.0
 *
 * Global rules for this file:
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 looping constructs per method. Looping
 *   constructs include for loops, while loops and do-while loops.
 * - You may not use nested loops.
 * - You may not declare any file-level variables.
 * - You may not use switch statements.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any other method from this or
 *   another file to implement any method.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from string literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 *
 * Method-specific rules for this file:
 * - You may not use multiplication, division or modulus in any method, EXCEPT
 *   decimalStringToInt
 * - You may declare exactly one String variable each in intToOctalString and
 *   and BinaryStringToHexString.
 */
public class Bases
{
    /**
     * Convert a string containing ASCII characters (in binary) to an int.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("111"); // => 7
     */
    public static int binaryStringToInt(String binary)
    {
        int newInt = 0;
        int multiply = 0;
        for (int i = binary.length() - 1; i >= 0; i--) {
            if (binary.charAt(i) == '1') {
                newInt = newInt + (1 << multiply);
            }
            multiply++;
        }
        return newInt;
    }

    /**
     * Convert a string containing ASCII characters (in decimal) to an int.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("123"); // => 123
     *
     * You may use multiplication, division, and modulus in this method.
     */
    public static int decimalStringToInt(String decimal)
    {
        int newInt = 0;
        int power= 1;
        for (int i = decimal.length() - 1; i >= 0; i--) {
            newInt += power * ((int) decimal.charAt(i) - 48);
            power *= 10;
        }
        return newInt;
    }

    /**
     * Convert a string containing ASCII characters (in hex) to an int.
     * The input string will only contain numbers and uppercase letters A-F.
     * You do not need to handle negative numbers. The Strings we will pass in will be
     * valid hexadecimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: hexStringToInt("A6"); // => 166
     */
    public static int hexStringToInt(String hex)
    {
        int newInt = 0;
        int multiply = 0;
        for (int i = hex.length() - 1; i >= 0; i--) {
            int ascii = ((int) hex.charAt(i));
            if (ascii >= 65) {
                newInt += (ascii - 55) << multiply;
            } else {
                newInt += (ascii - 48) << multiply;
            }
            multiply += 4;
        }
        return newInt;
    }

    /**
     * Convert a int into a String containing ASCII characters (in octal).
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters necessary to
     * represent the number that was passed in.
     *
     * Example: intToOctalString(10); // => "12"
     *
     * You may declare one String variable in this method.
     */
    public static String intToOctalString(int octal)
    {
       String var = "";
       if (octal == 0) {
           var = "0";
           return var;
       }
       while (octal != 0) {
           var = (char) ((octal - ((octal >> 3) << 3) + 48)) + var;
           octal = octal >> 3;
       }
       return var;
    }

    /**
     * Convert a String containing ASCII characters representing a number in binary into 
     * a String containing ASCII characters that represent that same value in hexadecimal.
     * The output string should only contain numbers and uppercase letters A-F.
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters necessary to
     * represent the number that was passed in.
     * The length of all the binary strings passed in will be of size 16.
     *
     * Example: binaryStringToHexString("0010111110100001"); // => 2FA1
     *
     * You may declare one String variable in this method.
     */
    public static String binaryStringToHexString(String binary)
    {
        int counter = 0;
        int binaryNum = 0;
        int multiply = 0;
        String hex = "";
        for (int i = binary.length() - 1; i >= 0; i--) {
            counter++;
            binaryNum = binaryNum + (((int)(binary.charAt(i)) - 48) << multiply);
            multiply++;
            if (counter == 4) {
                if (binaryNum > 9) {
                    hex = (char)(binaryNum + 55) + hex;
                    counter = 0;
                    multiply = 0;
                    binaryNum = 0;
                } else {
                    hex = (char)(binaryNum + 48) + hex;
                    counter = 0;
                    multiply = 0;
                    binaryNum = 0;
                }
            }
        }
        return hex;
    }
}
