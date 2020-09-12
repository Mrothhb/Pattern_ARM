/*
 * Filename: commandLoop.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 6th, 2019
 * Sources of help: Textbook, cse 30 website, lecture notes, discussion notes.
 */

#include <stdio.h>
#include "pa2.h"
#include "pa2Strings.h"
#include <errno.h>
#include <stdlib.h>
#include <string.h>
/*
 * Function Name: commandLoop()
 * Function Prototype: void commandLoop( char on, char off );
 * Description: This function allows the user to interactively manipulate the 
 *              bits in the pattern.
 * Parameters: on the on character, off the off character  
 * Side Effects: The interactive user display will appear and allow the user to
 *               issue commands.
 * Error Conditions: Handeled case by case below.
 *                    
 * Return Value: None. 
 */
void commandLoop( char on, char off ) {

  // Hold the validity for return values
  int valid_check = 0;  
  int command_index;
  // Create a buffer to read in strings from terminal  
  char buffer[BUFSIZ];  
  //  The array of commands the user might enter
  const char * LIST_COMMANDS[] = COMMANDS;
  unsigned int pattern[PATTERN_LEN] = { 0 };
  // The alphabet and digit patterns 
  const char * alphabetPatterns[] = ALPHABET_PATTERNS;
  const char * digitPatterns[] = DIGIT_PATTERNS;

  // Check if input is coming from stdin or from an input file 
  valid_check = shouldPrompt(); 

  // Print the prompt 
  if( valid_check ) {

    fprintf( stdout, STR_COMMAND_USAGE ); 

  }

  // Start the loop for all possible commands a user might enter 
  for(PRINT_PROMPT; fgets( buffer, BUFSIZ, stdin ); PRINT_PROMPT ) {

    // Set the newline character to Null 
    char * pos = strchr( buffer, '\n' );

    if( pos != NULL ) {
      *pos = '\0';
    }

    // parse the commands from the string input by the user 
    char * commandName = strtok( buffer, DELIM );

    // If no arguments are input then reprommpt thbe user for input 
    if( !(commandName )) {
      continue;
    }

    // Find the corresponding command entered by the user 
    else {

      command_index = findCommand(commandName, LIST_COMMANDS);

      // If the user entered an invalid command name print the error message 
      if( command_index == INVALID_ENTRY){
        fprintf( stdout, STR_ERR_BAD_COMMAND );
        continue;
      }

      // hold the first and second arguments entered in local variables 
      char * command1 = strtok( NULL, DELIM );
      char * command2 = strtok( NULL, DELIM );

      //  end pointer for the conversion of a string to long 
      char * endPtr;            
      errno = 0;

      // the parts for set, clear and toggle 
      unsigned int part0;
      unsigned int part1; 

      // Convert argument 1 and 2 into unsigned longs 
      if( command1 && command2 ) {
        part0 = strtoul( command1, &endPtr, PATTERN_BASE);
        part1 = strtoul( command2, &endPtr, PATTERN_BASE);
      }

      // Set the error flag to 0
      errno = 0;

      // Determine which command name was entered  
      switch( command_index ) {

        // Print the list of options again 
        case HELP:
          fprintf( stdout, STR_COMMAND_USAGE );
          break;

        // Set the pattern  
        case SET:

          // check if there isnt enough arguments
          if( !command1 || !command2 ) {
            fprintf(stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }

          // Check if theres extra arguments 
          if( strtok(NULL, DELIM )!= NULL ) {
            fprintf(stdout, STR_ERR_EXTRA_ARG);
            continue;
          }

          // Check if the argument is valid entry 
          if( errno != 0 || *endPtr != '\0' ) {
            fprintf( stdout, STR_ERR_PATTERN_INVALID );
            break;
          }

          // Set the pattern with part0 and part1
          set( pattern, part0, part1 );

          // print the pattern to stdout 
          printPattern( pattern, on, off);
          break;

        // Clear the pattern 
        case CLEAR:

          // check if theres less than two arguments 
          if( !command1 || !command2 ) {
            fprintf(stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }

          // check if ther is extra arguments 
          if( strtok(NULL, DELIM) != NULL ) {
            fprintf(stdout, STR_ERR_EXTRA_ARG);
            continue;
          }

          // Check if the argumenta are invalid 
          if( errno != 0 || *endPtr != '\0' ) {
            fprintf( stdout, STR_ERR_PATTERN_INVALID );
            break;
          }

          // clear the pattern with the part0 and part1
          clear( pattern, part0, part1 );

          // print the pattern to stdout 
          printPattern( pattern, on, off);
          break;

        // Toggle the pattern 
        case TOGGLE:

          // Check if missing both arguments 
          if( !command1 || !command2 ) {
            fprintf(stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }

          // Check if theres extra arguments 
          if( strtok(NULL, DELIM ) != NULL ) {
            fprintf(stdout, STR_ERR_EXTRA_ARG);
            continue;
          }

          // Check if the arguments are invalid
          if( errno != 0 || *endPtr != '\0' ) {
            fprintf( stdout, STR_ERR_PATTERN_INVALID );
            break;
          }

          // toggle the pattern with part0 and part1
          toggle( pattern, part0, part1 );
          // print the pattern to stdout 
          printPattern( pattern, on, off);
          break;

        // invert the pattern 
        case INVERT:

          // check if any arguments are input 
          if(command1 || command2 ){
            fprintf(stdout, STR_ERR_EXTRA_ARG );
            break;
          }

          // invert the pattern 
          invert(pattern);
          // print the pattern to stdout 
          printPattern(pattern, on, off);
          break;

        // print a character to stdout 
        case CHARACTER:

          // check for a first argument 
          if( !command1 ) {
            fprintf( stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }
          // check for a second argument 
          if( command2 ) {
            fprintf( stdout, STR_ERR_EXTRA_ARG );
            break;
          }

          // check if the argument conatains more than one char 
          if( strlen( command1 ) > MIN_EXPECTED_ARGS ) {
            fprintf(stdout, STR_ERR_CHAR_COMMAND_SINGLE );
            break;
          }

          // extract the first character from the argument 
          char chrctr = command1[PROG_NAME_IDX];

          // check for successful character set 
          command_index = character( pattern, chrctr, 
              alphabetPatterns, digitPatterns );

          // if the character set did not successfully convert
          if( valid_check == -1 ) {
            fprintf( stdout, STR_ERR_CHAR_INVALID );
            break;
          }

          // print the pattern to stdout 
          printPattern(pattern, on, off );
          break;

        // say the string entered to stdout 
        case SAY:

          // check if the first argument is missing
          if( !command1 ) {
            fprintf(stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }

          // check if theres more than one argument 
          if( command2 ) {
            fprintf(stdout, STR_ERR_EXTRA_ARG );
            break;
          }

          // say the string to stdout 
          say( command1, on, off );
          break;

        // scroll the pattern 
        case SCROLL_HORIZONTAL:

          // check if theres isnt a first argument 
          if( !command1 ) {
            fprintf(stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }

          // check if the second command exists 
          if( command2 != NULL ) {
            fprintf( stdout, STR_ERR_EXTRA_ARG );
            break;
          }  

          // convert the string to a long 
          signed int offset_H = strtol( command1, &endPtr, OFFSET_BASE );

          // check to see if the conversion was successful 
          if( errno != 0 || *endPtr != '\0' ) {
            fprintf( stdout, STR_ERR_INT_INVALID );
            break;
          }

          // scroll the pattern by offset 
          scrollHorizontal( pattern, offset_H );

          // print the pattern to stdout 
          printPattern( pattern, on, off );
          break;

        // scroll the pattern 
        case SCROLL_VERTICAL:

          // check for the first command 
          if( !command1 ) {
            fprintf(stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }

          // check if the second command exists 
          if( command2 != NULL) {
            fprintf( stdout, STR_ERR_EXTRA_ARG );
            break;
          }  

          // convert the string to a long 
          signed int offset_V = strtol( command1, &endPtr, OFFSET_BASE );

          // check if the conversion was successful 
          if( errno != 0 || *endPtr != '\0' ) {
            fprintf( stdout, STR_ERR_INT_INVALID );
            break;
          }

          // scroll the pattern   
          scrollVertical( pattern, offset_V );

          // print the pattern to stdout 
          printPattern( pattern, on, off );
          break;

        // translate the pattern 
        case TRANSLATE:

          // check for missing arguments 
          if( !command1 || !command2 ) {
            fprintf(stdout, STR_ERR_COMMAND_MISSING_ARG );
            break;
          }

          // check for extra arguments 
          if( strtok(NULL, DELIM) != NULL) {
            fprintf(stdout, STR_ERR_EXTRA_ARG);
            break;
          }

          // convert the strings into longs 
          unsigned int offsetH = strtol( command1, &endPtr, OFFSET_BASE );

          // check if the conversion was succesful 
          if( errno != 0 || *endPtr != '\0' ) {
            fprintf( stdout, STR_ERR_INT_INVALID );
            break;
          }

          unsigned int offsetV = strtol( command2, &endPtr, OFFSET_BASE );
          // check if the conversion was succesful 
          if( errno != 0 || *endPtr != '\0' ) {
            fprintf( stdout, STR_ERR_INT_INVALID );
            break;
          }

        
          // translate the pattern and print to stdout 
          translate( pattern, offsetH, offsetV );
          printPattern( pattern, on, off );
          break;
      }
    }
  }

  // Print the end of prompt 
  fprintf( stdout, STR_END_PROMPT );

}
