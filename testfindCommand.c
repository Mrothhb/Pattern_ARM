/*
 * Filename: testfindCommand.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of help: Textbook, lecture notes, discussion notes.
 */

#include <stdio.h>
#include <string.h>
#include "pa2.h"
#include "test.h"

/*
 * Unit tests for findCommand()
 * Look for the given cmdString in commands and return its index.
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
  const char * cmdStr9 = "scrollVertical";

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

  index = findCommand( cmdStr9, commandStr );

  TEST( index == 7 );

}

int main( void ) {

  fprintf( stderr, "Running tests for findCommand...\n" );
  testfindCommand();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
