/*
 * Filename: testcharacter.c
 * Author: TODO
 * UserId: TODO
 * Date: TODO
 * Sources of help: TODO
 */

#include <stdio.h>

#include "pa2.h"
#include "test.h"

/*
 * Unit Test for loadPatterString.c TODO
 *
 * Goes through each character in patternStrand, depending on its value, sets 
 * the bits in patternto either be on or off. The patternStris assumed to be 
 * exactly 64 characters long, where each '@'(DEFAULT_ON_CHAR) character 
 * represents an "on" bit and each '-'(DEFAULT_OFF_CHAR) character represents an
 * "off" bit.
 *
 * */
void testcharacter() {
  unsigned int pattern[PATTERN_LEN] = { 0 };
  const char *alphabet_patterns[] = ALPHABET_PATTERNS;
  const char *digit_patterns[] = DIGIT_PATTERNS;
  unsigned int pattern_test[PATTERN_LEN] = { 0 };

  character( pattern,'B', alphabet_patterns, digit_patterns );
  loadPatternString(pattern_test, alphabet_patterns[1]);
  TEST( pattern[0] == pattern_test[0] );
  TEST( pattern[1] == pattern_test[1] );

  character( pattern,'9', alphabet_patterns, digit_patterns );
  loadPatternString(pattern_test, digit_patterns[9]);
  TEST( pattern[0] == pattern_test[0] );
  TEST( pattern[1] == pattern_test[1] );



}

int main( void ) {

  fprintf( stderr, "Running tests for testcharacter...\n" );
  testcharacter();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
