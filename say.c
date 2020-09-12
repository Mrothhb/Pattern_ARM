/*
 * Filename: say.c
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: May 6th, 2019
 * Sources of help: textbook, cse30 website, lecture notes and discussion notes.
 */

#include <stdio.h>
#include "pa2.h"
#include "pa2Strings.h"

/*
 * Function Name: say()
 * Function Prototype: void say( const char * str, char on, char off );
 * Description: This function will take user input as a string of characters
 *              and print the string out to stdout in sequence. 
 * Parameters:  str, the string to print out, on the character to display on 
 *              in, off, the character to diplay off in. 
 * Side Effects: The string of characters is printed in sequence to stdout. 
 *             
 * Error Conditions: A character in str is not found in the lookup table. 
 *                   In this case, print the corresponding error message to
 *                   stdout.. 
 *                    
 * Return Value: None.     
 */
void say( const char * str, char on, char off ) {

  // The pattern to hold bits that represent the characters in str
  unsigned int pattern[PATTERN_LEN] = { 0 };
  // The patterns for each letter in the alphabet
  const char *alphabet_patterns[] = ALPHABET_PATTERNS;
  // The patterns for each digit 0 - 9
  const char *digit_patterns[] = DIGIT_PATTERNS;
  // check for validity from character 
  int isValid = 1;
  int i = 0;
  char testChar;
  
  // Loop though each character in the string parameter
  while(str[i]) {
    
    // test each character in the string 
    testChar = str[i];
    // Call character function to get the pattern for the character in string
    isValid = character( pattern, testChar, alphabet_patterns, digit_patterns );

    // If the character is invalid, then print the error message 
    if( isValid ==  INVALID_ENTRY ) {
      fprintf(stdout, STR_ERR_SAY_INVALID_CHAR);
    }

    // print the character to stdout 
    else {
      printPattern( pattern, on, off );
    }

    i++;
  }
}
