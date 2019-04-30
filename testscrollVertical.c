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
 * void TODO scrollHorizontal( unsigned int pattern[], const int offset );
 *
 * Scroll horizontally by offset.
 *    If offset is positive, shift bits right.
 *    If offset is negative, shift bits left.
 */
void testscrollVertical() {

  unsigned int pattern[PATTERN_LEN] = { 0 };

  pattern[0] = 0xFEDCBA98;
  pattern[1] = 0x76543210;

  scrollVertical( pattern, -1);
  
  TEST( pattern[0] == 0x10FEDCBA);
  TEST( pattern[1] == 0x98765432); 

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, 1);
  
  TEST( pattern[0] == 0xFFFFFFAA);
  TEST( pattern[1] == 0xAAAAAAFF); 


  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, -2);
  
  TEST( pattern[0] == 0xAAAAFFFF);
  TEST( pattern[1] == 0xFFFFAAAA); 
  printf(" pattern[0] %x \n", pattern[0]);
  printf(" pattern[1] %x \n", pattern[1]);

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, 9);
  
  TEST( pattern[0] == 0xFFFFFFAA);
  TEST( pattern[1] == 0xAAAAAAFF); 
  printf(" pattern[0] %x \n", pattern[0]);
  printf(" pattern[1] %x \n", pattern[1]);

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, -9);
  
  TEST( pattern[0] == 0xAAFFFFFF);
  TEST( pattern[1] == 0xFFAAAAAA); 
  printf(" pattern[0] %x \n", pattern[0]);
  printf(" pattern[1] %x \n", pattern[1]);

}

int main( void ) {

  fprintf( stderr, "Running tests for scrollHorizontal...\n" );
  testscrollVertical();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
