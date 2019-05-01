/*
 * Filename: set.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: May 1st 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53		@ Version of our Pis


	.equ	FP_OFFSET, 4		@ Offset from sp to set fp
	
	.global	set			@ Specify set as a global symbol

	.equ	PARAM_SPACE, 16		@ allocate space for the parameters
	.equ	PATTERN_1_OFFSET, -8	@ allocate space for pattern[1]	
	.equ	PATTERN_0_OFFSET, -12	@ allocate space for the pattern[0]
	.equ	PART0_OFFSET, -16	@ allocate space for part0
	.equ	PART1_OFFSET, -20	@ allocate space for part1
	.equ	PATTERN_INCR, 4		@ access the next element in pattern[]

	.text				@ Switch to Text segment 
	.align 2			@ Align on evenly divisible by 4 byte 
					@ address .align n where 2^n determines 
					@ alignment
/*
 * Function Name: set()
 * Function Prototype: void set( unsigned int pattern[], unsigned int part0, 
 			unsigned int par1 );
 * Description: This function turns on the specified bits in pattern with the 
 * 		bit patterns part 0 and part1. If a bit value in part0 or part1 
 *		is 1, then its corresponding bit in pattern should also become 1
 *		However, if the bit value in part0 or part1 is 0, then its 
 *		corresponding bit in pattern should remain the same.
 * Parameters: 	pattern[] the bit pattern to change, part0 and part1 the bit 
 * 	       	patterns to change the bits in pattern[]
 * Side Effects: None
 * Error Conditions: argument is more than one character will produce error. 
 * Return Value: None.
 *
 * Registers used:
 *	r0 - arg 1 -- ( parameter ) the address of pattern[]
 *	r1 - arg 2 -- ( parameter ) the part0 parameter a bit pattern to clear
 *	r2 - arg 3 -- ( parameter ) the part1 parameter a bit pattern to clear
 *	r3 - instr -- used for computational operations and temp for storage 
 *  		      during loads and stores to memory.
 * Stack variables:
 *	pattern[0] - [fp -12] --  holds the memory address to pattern[] in arg 1
 *				  and the pattern[0] element.
 *	pattern[1] - [fp -8]  --  holds the pattern[1] value from arg 1
 *	part0	   - [fp -16] --  holds the bit pattern from arg 2
 *	part1      - [fp -20] --  holds the bit pattern from arg 3	
 */

set:
@ Standard prologue
	push	{fp, lr}			@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET		@ Set fp to base of saved 
						@ registers
						@ Uses 4, from (#_of_regs_saved 
@ Allocate space to store the parameters 	@ - 1)*4.
	sub	sp, sp, PARAM_SPACE 		@ allocate space for the param-
						@ eters
	ldr	r3, [r0]			@ load value in pattern[0] in r3
	str	r3, [fp, PATTERN_0_OFFSET]	@ store pattern[0] in memory
	ldr	r3, [r0, PATTERN_INCR]		@ load value in pattern[1] in r3
	str	r3, [fp, PATTERN_1_OFFSET]	@ store pattern[1] in memory

	str	r1, [fp, PART0_OFFSET]		@ store part0 in memory
	str	r2, [fp, PART1_OFFSET]		@ store part1 in memory

@ first OR operation on pattern[0]
	ldr	r3, [fp, PATTERN_0_OFFSET]	@ get the current value of 
						@ pattern[0]
	ldr	r2, [fp, PART0_OFFSET]		@ get the current value of part0
	orr	r3, r3, r2			@ OR pattern[0] with part0
	str	r3, [r0]			@ update pattern[0] = r3
@ second OR operation on pattern[1]
	ldr	r3, [fp, PATTERN_1_OFFSET]	@ get the current value of patt-
						@ ern[1]
	ldr	r2, [fp, PART1_OFFSET]		@ get the value of par1
	orr	r3, r3, r2			@ pattern[1] OR part1
	str	r3, [r0, PATTERN_INCR]		@ store r3 in pattern[1]

@ Standard epilogue
	sub	sp, fp, FP_OFFSET		@ Set sp to top of saved regis-
						@ ters
	pop	{fp, pc}			@ Restore fp; restore lr into pc
						@ for
						@  return 
