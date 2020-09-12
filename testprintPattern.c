
/*
 * Filename: testprintPattern.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of help: Textbook, lecture notes, discussion notes, cse 30 website.
 */

#include <stdio.h>
#include "pa2.h"
#include "test.h"

/*
 * Unit Test for TODO
 *
 *
 * */
void testprintPattern() {

  unsigned int pattern[PATTERN_LEN] = { 0 };
  
  // Test offset = 0: shouldn't move
  pattern[0] = 0xBEEFCAFE;
  pattern[1] = 0xFEEDBEED;

  printPattern( pattern,'*', '#'); 

  pattern[0] = 0xBEEFCAFE;
  pattern[1] = 0xFEEDBEED;

  printPattern( pattern,'*', '#'); 
   
 
}

int main( void ) {

  fprintf( stderr, "Running tests for printPattern...\n" );
  testprintPattern();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
