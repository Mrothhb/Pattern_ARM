/*
 * Filename: invert.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: May 6th, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53		@ Version of our Pis
	.syntax	unified			@ Modern ARM syntax

	.equ	FP_OFFSET, 4		@ Offset from sp to set fp
	
	.global	invert			@ Specify invert as a global symbol

@ Formal farameters
	.equ	PARAM_SPACE, 8		@ allocate space for the parameters
	.equ	LOCAL_SPACE, 8		@ allocate space for the local variables

	.equ	PATTERN_OFFSET, -16	@ allocate space for pattern[0]
@ Local variables 
	.equ	MASK_OFFSET, -8		@ allocate space for MASK 0xFFFFFFFF
@ Constants	
	.equ	PATTERN_INCR, 4		@ access the next element in pattern[1]
	.equ	MASK, 0xFFFFFFFF	@ The value of the MASK

	.text				@ Switch to Text segment 
	.align 2			@ Align on evenly divisible by 4 byte 
					@ address .align n where 2^n determines 
					@ alignment
/*
 * Function Name: invert()
 * Function Prototype: void invert( unsigned int pattern[] );
 * Description: Inverts all the bits in pattern (0 to 1 and 1 to 0). 
 * Parameters:	pattern[] the bit pattern to change
 * Side Effects: invert all the bits in the pattern.
 * Error Conditions: None.
 * Return Value: None.
 *
 * Registers used:
 *	r0 - arg 1 -- ( parameter ) the address of pattern[]
 *	r3 - instr -- used for computational operations and temp for storage 
 *  		      during loads and stores to memory.
 *	
 * Stack variables:
 *	pattern[0] - [fp -16] --  holds the memory address to pattern[] in arg 1
 *				  and the pattern[0] element.
 *	MASK	   - [fp -8]  --  holds the MASK to flip the bits.
 */

invert:
@ Standard prologue
	push	{fp, lr}			@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET		@ Set fp to base of saved 
						@ registers
						@ Uses 4, from (#_of_regs_saved 
						@ - 1)*4.
@ Allocate space for the local variables 
	sub	sp, sp, LOCAL_SPACE		@ allocate space for the local 
						@ variables on the stack
	ldr	r3, =MASK			@ Store the MASK on the stack
	str	r3, [fp, MASK_OFFSET]		@ MASK = 0xFFFFFFFF;

@ Allocate space for the formal parameters	
	sub	sp, sp, PARAM_SPACE 		@ allocate space for the param-
						@ eters
	str	r0, [fp, PATTERN_OFFSET]	@ store the address of pattern

@ Invert all the bits in the pattern[0]

	ldr	r0, [fp, PATTERN_OFFSET]	@ get the memory address pattern
	ldr	r0, [r0]			@ get the value of pattern[0]
	ldr	r3, [fp, MASK_OFFSET]		@ get the MASK value 
	eor	r0, r0, r3			@ XOR pattern[0] with MASK
	ldr	r3, [fp, PATTERN_OFFSET]	@ get the address of pattern[]
	str	r0, [r3]			@ update pattern[0] 
	
@ Invert all the bits in the pattern[1]

	ldr	r0, [fp, PATTERN_OFFSET]	@ get the current value of patt-
						@ ern[1]
	add	r0, r0, PATTERN_INCR		@ increment to get the next 
						@ memory address of pattern[]
	ldr	r0, [r0]			@ get the value of pattern[1]
	ldr	r3, [fp, MASK_OFFSET]		@ get the MASK
	eor	r0, r0, r3			@ XOR pattern[1] with MASK
	ldr	r3, [fp, PATTERN_OFFSET]	@ get the address of pattern[]
	add	r3, r3, PATTERN_INCR		@ incrment to pattern[1]
	str	r0, [r3]			@ store r0 in pattern[1]

@ Standard epilogue
	sub	sp, fp, FP_OFFSET		@ Set sp to top of saved regis-
						@ ters
	pop	{fp, pc}			@ Restore fp; restore lr into pc
						@ for
						@  return 
