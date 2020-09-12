/*
 * Filename: testinvert.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 1st, 2019
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
void testtrans() {
  unsigned int pattern[PATTERN_LEN] = { 0 };
  unsigned int pattern0;
  unsigned int pattern1;

  pattern0 = 0xAAAAAAAA;
  pattern1 = 0xFFFFFFFF;

  // Test values should 
  pattern[0] = pattern0;
  pattern[1] = pattern1;

  translate( pattern, 1, 1 );

  TEST( pattern[0] == 0xFF555555 );
  TEST( pattern[1] == 0x55FFFFFF );
}

int main( void ) {

  fprintf( stderr, "Running tests for toggle...\n" );
  testtrans();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
