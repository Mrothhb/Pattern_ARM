/*
 * Filename: testscrollHorizontal.c
 * Author: TODO
 * UserId: TODO
 * Date: TODO
 * Sources of help: TODO
 */

#include <stdio.h>

#include "pa2.h"
#include "test.h"

/*
 * Unit Test for scrollHorizontal.c
 *
 * void scrollHorizontal( unsigned int pattern[], const int offset );
 *
 * Scroll horizontally by offset.
 *    If offset is positive, shift bits right.
 *    If offset is negative, shift bits left.
 */
void testscrollHorizontal() {
  unsigned int pattern[PATTERN_LEN] = { 0 };

  // Test offset = 0: shouldn't move
  pattern[0] = 0xAAAAAAAA;
  pattern[1] = 0xCCCCCCCC;

  scrollHorizontal( pattern, 0 );

  TEST( pattern[0] == 0xAAAAAAAA );
  TEST( pattern[1] == 0xCCCCCCCC );

  // Test offset = 4: should swap the nibbles in each byte
  pattern[0] = 0xABCDEF01;
  pattern[1] = 0xCCCCCCCC;

  scrollHorizontal( pattern, 4 );

  TEST( pattern[0] == 0xBADCFE10 );
  TEST( pattern[1] == 0xCCCCCCCC );

  /*
   * TODO: YOU MUST WRITE MORE TEST CASES FOR FULL POINTS!
   *
   * Some things to think about are error cases, extreme cases, normal cases,
   * abnormal cases, etc.
   */

  pattern[0] = /* TODO */;
  pattern[1] = /* TODO */;

  scrollHorizontal( pattern, /* TODO */ );

  TEST( pattern[0] == /* TODO */ );
  TEST( pattern[1] == /* TODO */ );
}

int main( void ) {

  fprintf( stderr, "Running tests for scrollHorizontal...\n" );
  testscrollHorizontal();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
