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
 * Unit Test for loadPatterString.c
 *
 * Goes through each character in patternStrand, depending on its value, sets 
 * the bits in patternto either be on or off. The patternStris assumed to be 
 * exactly 64 characters long, where each '@'(DEFAULT_ON_CHAR) character 
 * represents an "on" bit and each '-'(DEFAULT_OFF_CHAR) character represents an
 * "off" bit.
 *
 * */
void testloadPatternString() {
  unsigned int pattern[PATTERN_LEN] = { 0 };
  const char * patternStr = 
    "@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-";
  const char * patternStr2 = 
    "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
  const char * patternStr3 = 
    "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--------------------------------";
  const char * patternStr4 = 
    "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
  const char * patternStr5 = 
    "@@@@@@@@@@--------";


  // test given string 
  loadPatternString( pattern, patternStr );
  TEST( pattern[0] == 0xAAAAAAAA );
  TEST( pattern[1] == 0xAAAAAAAA );

  // test all default on 
  loadPatternString( pattern, patternStr2 );
  TEST ( pattern[0] == 0xFFFFFFFF );
  TEST ( pattern[1] == 0xFFFFFFFF );
  
  // test half and half string 
  loadPatternString( pattern, patternStr3 );
  TEST ( pattern[0] == 0xFFFFFFFF );
  TEST ( pattern[1] == 0x00000000 );

  // String of non default character 
  loadPatternString( pattern, patternStr4 );
  TEST ( pattern[0] == 0 );
  TEST ( pattern[1] == 0 );

  // Test length < 64 string 
  loadPatternString( pattern, patternStr5 );
  TEST ( pattern[0] == 0xFFC00000 );
  TEST ( pattern[1] == 0 );
}

int main( void ) {

  fprintf( stderr, "Running tests for loadPatternString...\n" );
  testloadPatternString();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
