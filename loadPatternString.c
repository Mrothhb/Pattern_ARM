/*
 * Filename: loadPatternString.c
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of help: textbook, cse30 website, lecture notes and discussion notes.
 */

#include <stdio.h>
#include "pa2.h"

/*
 * Function Name: loadPatternString()
 * Function Prototype:  void loadPatternString( unsigned int pattern[], const 
 *                           char * patternStr );
 * Description:  Goes through each character in patternStr and, depending on its
 *               value, sets the bits in pattern to either be on or off. The 
 *               patternStr is assumed to be exactly 64 characters long, where 
 *               each '@'(DEFAULT_ON_CHAR) character represents an "on" bit and
 *                each '-'(DEFAULT_OFF_CHAR) character represents an "off" bit.
 * Parameters:   pattern[] is the pattern to alter bits, patternStr is the 
 *               string containing a seqeunce of chars to use as a bit set 
 *               indicator.
 * Side Effects: The pattern from the indicated string will set the bits in the
 *               pattern[] array to the desired format.
 *             
 * Error Conditions: None. 
 *                    
 * Return Value:     None.     
 */
void loadPatternString( unsigned int pattern[], const char * patternStr ) {

  // The mask will act as a bit shifting tool to set or clear bits in pattern[]
  unsigned int MASK = 0x80000000;
  int i;

  // Initialize the patterns to zero 
  pattern[0] = 0;
  pattern[1] = 0;

  // Set the bits for pattern[0]
  for(i = 0; i < HALF_PATTERN_STR_LEN; i++ ) {

    // If the character in string is '@' default on set the bit to 1
    if( patternStr[i] == DEFAULT_ON_CHAR ) {
      ( pattern[0] = pattern[0] | MASK );
      MASK = MASK >> 1;
    }

    // If the character in the string is '-' default off set the bit to 0
    else {
      MASK = MASK >> 1;
    } 
  }

  // Reset the MASK 
  MASK = 0x80000000;

  // Set the bits for pattern[1] 
  for(i = HALF_PATTERN_STR_LEN; i < PATTERN_STR_LEN; i++ ) {

    // If the character in string is '@' default on set the bit to 1
    if( patternStr[i] == DEFAULT_ON_CHAR ) {
      ( pattern[1] = pattern[1] | MASK );
     MASK = MASK >> 1;
    }

    // If the character in the string is '-' default off set the bit to 0
    else {
     MASK = MASK >> 1;
    }
  }
}
