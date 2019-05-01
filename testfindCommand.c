/*
 * Filename: testscrollHorizontal.c
 * Author: TODO
 * UserId: TODO
 * Date: TODO
 * Sources of help: TODO
 */

#include <stdio.h>
#include <string.h>
#include "pa2.h"
#include "test.h"

/*
 * Function Name: TODO()
 * Function Prototype:  void scrollHorizontal( unsigned int pattern[], 
 *                                                              int offset );
 * Description:  This function will scroll pattern horizontally based on offset
 *               If offset is positive, scroll right and wrap the bits around to
 *               the left. If offset is negative, scroll left and wrap the bits 
 *               around to the right. 
 * Parameters:   pattern[] is the pattern to alter bits, offset the scroll 
 *               direction.
 * Side Effects: The bit pattern will shift horizontally in the pattern[]. 
 * Error Conditions: None. 
 *                    
 * Return Value:     TODO     
 */

void testfindCommand() {
  const char * commandStr[] = COMMANDS;
  const char * cmdStr = "toggle";
  const char * cmdStr2 = "help";
  const char * cmdStr3 = "nothere";
  const char * cmdStr4 = "characte";
  const char * cmdStr5 = "set set";
  const char * cmdStr6 = "toggle set";
  const char * cmdStr7 = " set";
  const char * cmdStr8 = " ";
  const char * nullStr = NULL;
  const char * nullPtr = NULL;

  int index;

  index = findCommand( cmdStr, commandStr );

  TEST( index == 2 );

  index = findCommand( cmdStr2, commandStr );

  TEST( index == 9 );

  index = findCommand( cmdStr3, commandStr );

  TEST( index == -1 );

  index = findCommand( cmdStr4, commandStr );

  TEST( index == -1 );

  index = findCommand( cmdStr5, commandStr );

  TEST( index == -1 );

  index = findCommand( cmdStr6, commandStr );

  TEST( index == -1 );

  index = findCommand( cmdStr7, commandStr );

  TEST( index == -1 );

  index = findCommand( cmdStr8, commandStr );

  TEST( index == -1 );

  index = findCommand( nullStr, commandStr );

  TEST( index == -1 );

  index = findCommand( cmdStr, nullPtr );

  TEST( index == -1 );
}

int main( void ) {

  fprintf( stderr, "Running tests for findCommand...\n" );
  testfindCommand();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
