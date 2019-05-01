/*
 * Filename: scrollHorizontal.c
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: TODO
 * Sources of help: textbook, cse30 website, lecture notes and discussion notes.
 */

#include <stdio.h>
#include "pa2.h"
#include <stdlib.h>

/**Helper function prototype to perform all of the operations on the bits**/
void scrollHorizontalRotator(unsigned int pattern[], int offset,
    int current_pattern);
/*
 * Function Name: scrollHorizontal()
 * Function Prototype:  void scrollHorizontal( unsigned int pattern[], 
 *                                                              int offset );
 * Description:  This function will scroll pattern horizontally based on offset
 *               If offset is positive, scroll right and wrap the bits around to
 *               the left. If offset is negative, scroll left and wrap the bits 
 *               around to the right. 
 * Parameters:   pattern[] is the pattern to alter bits, offset the scroll 
 *               direction.
 * Side Effects: The bit pattern will shift horizontally in the pattern[]. 
 * Error Conditions: None. 
 *                    
 * Return Value:     None.     
 */
void scrollHorizontal( unsigned int pattern[], int offset ) {

  // If the offset is zero we don't need to execute more unecessary code
  if ( offset == 0 ) { 
    return;
  }

  // The current pattern[] to perform bit operations on
  int current_pattern = 0;   

  // Call the rotator function twice for each pattern element in the array 
  scrollHorizontalRotator( pattern, offset, current_pattern );
  scrollHorizontalRotator( pattern, offset, ++current_pattern );
}

/*
 * Function Name: scrollHorizontalRotator()
 * Function Prototype:  void scrollHorizontalRotator( unsigned int pattern[], 
 *                                        int offset, int current_pattern );
 * Description:  This function will scroll pattern horizontally based on offset
 *               If offset is positive, scroll right and wrap the bits around to
 *               the left. If offset is negative, scroll left and wrap the bits 
 *               around to the right. 
 * Parameters:   pattern[] is the pattern to alter bits, offset the scroll 
 *               direction, current_pattern is the element index to peform the 
 *               bit operations on.
 * Side Effects: The bit pattern will shift horizontally in the pattern[]. 
 * Error Conditions: None. 
 *                    
 * Return Value:     None.     
 */
void scrollHorizontalRotator( unsigned int pattern[], int offset, 
    int current_pattern ) {

  // Mask to set and clear bits in the desired byte pattern
  unsigned int MSB_BYTE_MASK = 0xFF000000;
  // Mask to extract the bit in the current byte for the right most bit
  unsigned int r_bit_mask = 0x01000000;
  // Mask to extract the bit in the current byte for the left most bit
  unsigned int l_bit_mask = 0x80000000;
  // The current byte to bit manipulate in the pattern[] of 4 bytes
  unsigned int current_byte = 0;
  // The temp holder for the extracted bit to replace in the pattern 
  unsigned int temp_bit = 0;

  int i;
  int j;

  // Rotate the all the bytes in pattern[]
  for( i = 0; i < HALF_PATTERN_LEN; i++ ) {

    // Get the desired byte from the pattern[] 
    current_byte = pattern[current_pattern] & MSB_BYTE_MASK; 

    // Rotate the byte offset times 
    for( j = 0; j < abs(offset); j++) {

      // Offset is positive 
      if( offset > 0 ) {

        // Extract the right most bit from the pattern 
        temp_bit = current_byte & r_bit_mask;
        // Shift the bit all the way to the left
        temp_bit = temp_bit << (BYTE_BITWIDTH - 1);
        // Shift the current byte pattern one right to make room for new bit
        current_byte = current_byte >> 1;
        // Truncate any excess bits in the pattern 
        current_byte = current_byte & MSB_BYTE_MASK; 
      }
      // Offset is negative 
      else if( offset < 0 ) {

        // Extract the left most bit from the pattern 
        temp_bit = current_byte & l_bit_mask;
        // Shift the bit all the way right 
        temp_bit = temp_bit >> (BYTE_BITWIDTH - 1);
        // Shift the pattern one right to make room for the new bit 
        current_byte = current_byte << 1;
        // Truncate any excess bits in the pattern 
        current_byte = current_byte & MSB_BYTE_MASK;
      }
      // Insert the extracted and shifted bit back into the pattern 
      current_byte = current_byte | temp_bit;
    }

    // Insert the byte back into the pattern[]
    pattern[current_pattern] = current_byte | 
      (pattern[current_pattern] & ~MSB_BYTE_MASK);
    // Shift the Mask for the next byte pattern
    MSB_BYTE_MASK = MSB_BYTE_MASK >>  BYTE_BITWIDTH;
    // Shift the bit masks for the next byte pattern 
    r_bit_mask = r_bit_mask >> (BYTE_BITWIDTH);
    l_bit_mask = l_bit_mask >> (BYTE_BITWIDTH);
  }
}
