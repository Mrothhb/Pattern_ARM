/*
 * Filename: pa2.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 6th, 2019
 * Sources of help: Textbook, cse30 website, lecture notes, discussion notes.
 */

#include <stdio.h>
#include "pa2.h"
#include "pa2Strings.h"
#include <string.h>
#include <stdlib.h>

/*
 * Function Name: main()
 * Function Prototype: int main( int argc, char * argv[] );
 * Description: This is the main driver of the program. Its main tasks are to
 *              parse any command line arguments that are passed in and start
 *              the user-interactive mode. By default, the "on" character and 
 *              the "off" character should be DEFAULT_ON_CHAR and 
 *              DEFAULT_OFF_CHAR, respectively.
 * Parameters: argc is the argument counter, argv is each argument from the 
 *             command line.  
 * Side Effects: The program will be executed with the respective arguments. 
 * Error Conditions: invalid amount of arguments, or invalid argument types will
 *                   return EXIT_FAILURE.
 * Return Value: EXIT_SUCCESS on success, and EXIT_FAILURE on failure.    
 */
int main( int argc, char * argv[] ) {
  
  // The char values to print to stdout during prorgram execution
  char on = DEFAULT_ON_CHAR;
  char off = DEFAULT_OFF_CHAR;
  
  // If there are more than three arguments from the command line, print error.
  if( argc > MAX_EXPECTED_ARGS ) {
    fprintf( stderr, STR_USAGE, argv[0], on, off, MIN_ASCII, MAX_ASCII );
    return EXIT_FAILURE;
  }
  
  // determine if theres at least one argument from command line
  if( argc > ONE_ARG ) {  
    // set the argument to the on character
    on = *argv[ON_CHAR_IDX];

   }
  
  // determine if theres at least two arguments
  if( argc > TWO_ARGS ) {
    // set the second argument to off char 
    off = *argv[OFF_CHAR_IDX];

  }
   
  // If theres two or three arguments from the comand line
  if( argc > ONE_ARG && argc < THREE_ARGS ) {
    // check the length of each argument is valid 
    if( strlen(argv[ON_CHAR_IDX]) != ARG_LEN ) {
      fprintf( stderr, STR_ERR_SINGLE_CHAR, ON_ARG_NAME, argv[ON_CHAR_IDX]);
      return EXIT_FAILURE;
    }
  }

  // if the character is out of the ascii range 
  if( on < MIN_ASCII || on > MAX_ASCII ) {
    fprintf(stderr, STR_ERR_CHAR_RANGE, ON_ARG_NAME, on, MIN_ASCII, MAX_ASCII );
    return EXIT_FAILURE;
  }
  
  // check if the command line has three arguments 
  if( argc > TWO_ARGS ){
    // determine if the length of the argument is valid 
    if( strlen(argv[OFF_CHAR_IDX]) != ARG_LEN ) {
      fprintf( stderr, STR_ERR_SINGLE_CHAR, OFF_ARG_NAME, argv[OFF_CHAR_IDX] );
      return EXIT_FAILURE;
    }
  }
  
  // Check if the off char is within the ASCII RANGE 
  if( off < MIN_ASCII || off > MAX_ASCII ) {
    fprintf(stderr, STR_ERR_CHAR_RANGE, OFF_ARG_NAME, off, MIN_ASCII, 
          MAX_ASCII);
    return EXIT_FAILURE;
  }
  
  // If all subsequent error cases passed, then call the commandLoop 
  commandLoop(on, off);
  
  // return success
  return EXIT_SUCCESS;
}
