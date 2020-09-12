/*
 * Filename: testcharacter.c
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of help: Textbook, cse 30 website, lecture notes, discussion notes.
 */

#include <stdio.h>
#include "pa2.h"
#include "test.h"

/*
 * Unit Test for character.s
 * Fills patternwith the bit pattern of ch. If chis a letter, look up its bit
 * pattern in alphabetPatterns (uppercase letters A-Z). Otherwise, if chis a 
 * number, then look up its bit pattern in digitPatterns (digits 0-9). If its 
 * bit pattern is found, use it to set the bits in pattern.
 *
 *
 * */
void testcharacter() {
  unsigned int pattern[PATTERN_LEN] = { 0 };
  const char *alphabet_patterns[] = ALPHABET_PATTERNS;
  const char *digit_patterns[] = DIGIT_PATTERNS;
  unsigned int pattern_test[PATTERN_LEN] = { 0 };
  int return_value;

  return_value = character( pattern,'b', alphabet_patterns, digit_patterns );
  loadPatternString(pattern_test, alphabet_patterns[1]);
  TEST( pattern[0] == pattern_test[0] );
  TEST( pattern[1] == pattern_test[1] );
  printf( " pattern[0] is %x \n\n", pattern[0]);
  printf( " pattern[1] is %x \n\n", pattern[1]);
  TEST( return_value == 0 );
  pattern[0] = 0;
  pattern[1] = 0;

  return_value = character( pattern,'9', alphabet_patterns, digit_patterns );
  loadPatternString(pattern_test, digit_patterns[9]);
  TEST( pattern[0] == pattern_test[0] );
  TEST( pattern[1] == pattern_test[1] );
  TEST( return_value == 0 );
  pattern[0] = 0;
  pattern[1] = 0;

  return_value = character( pattern,'0', alphabet_patterns, digit_patterns );
  loadPatternString(pattern_test, digit_patterns[0]);
  TEST( pattern[0] == pattern_test[0] );
  TEST( pattern[1] == pattern_test[1] );
  TEST( return_value == 0 );
  pattern[0] = 0;
  pattern[1] = 0;

  return_value = character( pattern,'#', alphabet_patterns, digit_patterns );
  TEST( pattern[0] == 0);
  TEST( pattern[1] == 0);
  TEST( return_value == -1 );
  pattern[0] = 0;
  pattern[1] = 0;

  printf(" pattern[0] is %x \n\n", pattern[0] );

  printf(" pattern[1] is %x \n\n", pattern[1] );

  return_value = character( pattern,'A', alphabet_patterns, digit_patterns );
  loadPatternString(pattern_test, alphabet_patterns[0]);
  TEST( pattern[0] == pattern_test[0] );
  TEST( pattern[1] == pattern_test[1] );
  TEST( return_value == 0);
  pattern[0] = 0;
  pattern[1] = 0;


  return_value = character( pattern,'\0', alphabet_patterns, digit_patterns );
  TEST( pattern[0] == 0);
  TEST( pattern[1] == 0);
  TEST( return_value == -1 );
  pattern[0] = 0;
  pattern[1] = 0;

  return_value = character( pattern,'Z', alphabet_patterns, digit_patterns );
  loadPatternString(pattern_test, alphabet_patterns[25]);  
  TEST( pattern[0] == pattern_test[0]);
  TEST( pattern[1] == pattern_test[1]);
  TEST( return_value == 0 );
}

int main( void ) {

  fprintf( stderr, "Running tests for testcharacter...\n" );
  testcharacter();
  fprintf( stderr, "Done running tests!\n" );

  return 0;
}
