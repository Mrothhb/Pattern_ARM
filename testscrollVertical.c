/*
 * Filename: testscrollVertical.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of help: Textbook, cse 30 website, lecture notes, discussion notes.
 */

#include <stdio.h>
#include "pa2.h"
#include "test.h"

/*
 * Unit Test for scrollVertical.c
 * Scroll pattern vertically based on offset. If offset is positive, scroll down
 * and wrap the bits around to the top. If offsetis negative, scroll up and wrap
 * the bits around to the bottom.
 *
 */
void testscrollVertical() {

  unsigned int pattern[PATTERN_LEN] = { 0 };

  pattern[0] = 0xFEDCBA98;
  pattern[1] = 0x76543210;

  scrollVertical( pattern, 1);
  
  TEST( pattern[0] == 0x10FEDCBA);
  TEST( pattern[1] == 0x98765432); 

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, -1);
  
  TEST( pattern[0] == 0xFFFFFFAA);
  TEST( pattern[1] == 0xAAAAAAFF); 


  pattern[0] = 0xAAAAAAAA;
  pattern[1] = 0xFFFFFFFF;

  scrollVertical( pattern, -2);
  
  TEST( pattern[0] == 0xAAAAFFFF);
  TEST( pattern[1] == 0xFFFFAAAA); 

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, -9);
  
  TEST( pattern[0] == 0xFFFFFFAA);
  TEST( pattern[1] == 0xAAAAAAFF); 

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, 9);
  
  TEST( pattern[0] == 0xAAFFFFFF);
  TEST( pattern[1] == 0xFFAAAAAA); 
  
  pattern[0] = 0x88888888;
  pattern[1] = 0x10101010;

  scrollVertical( pattern, -1);
  
  TEST( pattern[0] == 0x88888810);
  TEST( pattern[1] == 0x10101088); 
 
  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, -64);
  
  TEST( pattern[0] == 0xFFFFFFFF);
  TEST( pattern[1] == 0xAAAAAAAA); 

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, 64);
  
  TEST( pattern[0] == 0xFFFFFFFF);
  TEST( pattern[1] == 0xAAAAAAAA); 

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, 65);
  
  TEST( pattern[0] == 0xAAFFFFFF);
  TEST( pattern[1] == 0xFFAAAAAA); 

  pattern[0] = 0xFFFFFFFF;
  pattern[1] = 0xAAAAAAAA;

  scrollVertical( pattern, 0);
  
  TEST( pattern[0] == 0xFFFFFFFF);
  TEST( pattern[1] == 0xAAAAAAAA); 

  pattern[0] = 0x0000000A;
  pattern[1] = 0x0000000F;

  scrollVertical( pattern, 1601);
  
  TEST( pattern[0] == 0x0F000000);
  TEST( pattern[1] == 0X0A000000); 
}

int main( void ) {

  fprintf( stderr, "Running tests for scrollVertical...\n" );
  testscrollVertical();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
