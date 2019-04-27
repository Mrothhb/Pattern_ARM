/*
 * Filename: loadPatternString.c
 * Author: TODO
 * UserId: TODO
 * Date: TODO
 * Sources of help: TODO
 */

#include <stdio.h>
#include "pa2.h"

void loadPatternString( unsigned int pattern[], const char * patternStr ) { 
  /*
   * Function Name: function name() TODO
   * Function Prototype: Definition of the function. For example, for main this
   *                     would be int main( int argc, char * argv[] );
   * Description:  Description of how the function behaves
   * Parameters:   Name
   *               any parameters passed into the function, and how they are
   *               used. If no parameters are used, say None
   * Side Effects: Any behaviors the function might exhibit that are not
   *               immediately apparent (related to the return value). 
   *               include updating a value pointed to by a parameter, 
   *               printing things to stdout/stderr, reading/writing from file
   *               parameters, etc (ask on Piazza if you are unsure if an action
   *               you 
   *               are taking has a side effect). If there are no side 
   *               effects, say None
   * Error Conditions: Explain any potential errors/exceptions that may occur if
   *                   your function is used incorrectly. If there are no error
   *                   conditions, say None
   * Return Value:     What does the return value of this function represent/what
   *                   will it be used for?
   */
  unsigned int MASK = 0x00000001;

  // Initialize the patterns to zero 
  pattern[0] = 0;
  pattern[1] = 0;

  for(i = 0; i < HALF_PATTERN_STR_LEN; i++ ) {
    if( *patternStr[i] == DEFAULT_ON_CHAR ) {
      ( pattern[0] = *pattern[0] | MASK );
      MASK << 1;
    }

    else if( *patternStr[i] == DEFAULT_OFF_CHAR ) {
      MASK << 1;
    }
  }

}
