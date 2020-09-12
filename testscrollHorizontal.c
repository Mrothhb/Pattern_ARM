/*
 * Filename: testscrollHorizontal.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of help: Texttbook, cse30 website, lecture notes, discussion notes.
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
  pattern[0] = 0x98765432;
  pattern[1] = 0xBABEFACE;

  scrollHorizontal( pattern, 4 );
  
  printf("pattern0 is %x \n\n\n ", pattern[0] );
/*
  TEST( pattern[0] == 0xAAAAAAAA );
  TEST( pattern[1] == 0xCCCCCCCC );

  // Test offset = 4: should swap the nibbles in each byte
  pattern[0] = 0xABCDEF01;
  pattern[1] = 0xCCCCCCCC;

  scrollHorizontal( pattern, 4 );

  TEST( pattern[0] == 0xBADCFE10 );
  TEST( pattern[1] == 0xCCCCCCCC );

  pattern[0] =  0xAAAAAAAA;
  pattern[1] =  0xAAAAAAAA;

  scrollHorizontal( pattern, 1);

  TEST( pattern[0] ==  0x55555555 );
  TEST( pattern[1] ==  0x55555555 );
  
  pattern[0] =  0x0;
  pattern[1] =  0xF0000000;
  scrollHorizontal( pattern, 1);
  TEST( pattern[0] ==  0x0 );
  TEST( pattern[1] ==  0x78000000 );

  
  pattern[0] =  0xEEEEEEEE;
  pattern[1] =  0x80000000;
  scrollHorizontal( pattern, -1);
  TEST( pattern[0] ==  0xDDDDDDDD);
  TEST( pattern[1] ==  0x1000000 );
   
  pattern[0] =  0x00000001;
  pattern[1] =  0xCCCCCCCC;
  scrollHorizontal( pattern, 1);
  TEST( pattern[0] ==  0x80 );

  pattern[0] =  0xFF000000;
  pattern[1] =  0x000000FF;
  scrollHorizontal( pattern, 10);
  TEST( pattern[0] ==  0xFF000000);
  TEST( pattern[1] == 0x000000FF);

  pattern[0] =  0x80;
  pattern[1] =  0x1;
  scrollHorizontal( pattern, -1 );
  TEST( pattern[0] ==  0x1);
  TEST( pattern[1] == 0x2);

  pattern[0] =  0x11;
  pattern[1] =  0x88;
  scrollHorizontal( pattern, 1);
  TEST( pattern[0] ==  0x88);
  TEST( pattern[1] == 0x44);

  pattern[0] =  0x1;
  pattern[1] =  0x8;
  scrollHorizontal( pattern, 1600);
  TEST( pattern[0] ==  0x1);
  TEST( pattern[1] == 0x8);
  */
 }

int main( void ) {

  fprintf( stderr, "Running tests for scrollHorizontal...\n" );
  testscrollHorizontal();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
