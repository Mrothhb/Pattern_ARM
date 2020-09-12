
/*
 * Filename: testsay.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date:
 * Sources of help: Textbook, cse30 website, lecture notes, discussion notes.
 */

#include <stdio.h>
#include "pa2.h"
#include "test.h"

/*
 * Unit Test 
 * Toggles all the bits in pattern specified in part0 and part1
 * If the bit value in part0 or part1 is 1, then its corresponding bit in 
 * pattern should invert (i.e. 1 becomes 0, and 0 becomes 1). However, if the 
 * bit value in part0 or part1 is 0, then the corresponding bit in pattern should
 * remain same.
 * 
 */
void testsay() {
 
  const char * str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  char on = '@';
  char off = '-';

  say( str, on, off );

 
}

int main( void ) {

  fprintf( stderr, "Running tests for say...\n" );
  testsay();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
