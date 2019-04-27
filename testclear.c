/*
 * Filename: testclear.c
 * Author: TODO
 * UserId: TODO
 * Date: TODO
 * Sources of help: TODO
 */

#include <stdio.h>

#include "pa2.h"
#include "test.h"

/*
 * Unit Test for clear.s
 *
 * void clear( unsigned int pattern[], unsigned int part0, unsigned int part1 );
 *
 * Works similar to set(), except this function turns off the specified bits in 
 * pattern with the bit patterns part0and part1. If a bit value in part0or part1
 * is 1, then its corresponding bit in patternshould become 0. However, if the 
 * bit value in part0or part1is 0, then its corresponding bit in patternshould
 * remain the same.
 */
void testclear() {
  unsigned int pattern[PATTERN_LEN] = { 0 };
  unsigned int pattern0;
  unsigned int pattern1;

  pattern0 = 0xAAAAAAAA;
  pattern1 = 0xCCCCCCCC;

  // Test values should 
  pattern[0] = pattern0;
  pattern[1] = pattern1;

  clear( pattern, 0xFFFFFFFF, 0xFFFFFFFF );

  TEST( pattern[0] == ~(pattern0 & 0xFFFFFFFF) );
  TEST( pattern[1] == ~(pattern1 & 0xFFFFFFFF) );

  pattern0 = 0xA;
  pattern1 = 0xCCCCCCCC;

  // Test 
  pattern[0] = pattern0;
  pattern[1] = pattern1;

  clear( pattern, 0xC, 0xEEEEEEEE);

  TEST( pattern[0] == ~(pattern0 & 0xC ) );
  TEST( pattern[1] == ~(pattern1 & 0xEEEEEEEE) );

  pattern0 = 123;
  pattern1 = 0002;

  pattern[0] = pattern0;
  pattern[1] = pattern1;

  clear( pattern, 0xABD , 0 );

  TEST( pattern[0] == ~(pattern0 & 0xABD ));
  TEST( pattern[1] == ~(pattern1 & 0 ));

  pattern0 = '\0';
  pattern1 = 'a';

  pattern[0] = pattern0;
  pattern[1] = pattern1;

  clear( pattern, -1 , 0xFAB );

  TEST( pattern[0] == ~(pattern0 & -1 ));
  TEST( pattern[1] == ~(pattern1 & 0xFAB ));

  pattern0 = 0xBABE;
  pattern1 = 0xFADED;

  pattern[0] = pattern0;
  pattern[1] = pattern1;

  clear( pattern, -500 , BUFSIZ );

  TEST( pattern[0] == ~(pattern0 & -500 ));
  TEST( pattern[1] == ~(pattern1 & BUFSIZ ));

  int i;
  unsigned int j = 5000;
  for( i = 0; i < j; i++) {
    pattern0 = i;
    pattern1 = j;
    pattern[0] = pattern0;
    pattern[1] = pattern1;
    clear(pattern, i , j);
    TEST( pattern[0] == ~(pattern0 & i));
    TEST( pattern[1] == ~(pattern1 & j));
    --j;
    }
}

int main( void ) {

  fprintf( stderr, "Running tests for clear...\n" );
  testclear();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
