/*
 * Filename: scrollVertical.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: TODO, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53		@ Version of our Pis
	.syntax	unified			@ Modern ARM syntax

	.equ	FP_OFFSET, 4		@ Offset from sp to set fp
	
	.global	scrollVertical		@ Specify scrollVertical as a global 
					@ symbol
	.equ	LOCAL_SPACE, 24		@ allocate space for the local variables
	.equ	PARAM_SPACE, 8		@ allocate space for the parameters
	.equ	PATTERN, -32		@ allocate space for pattern[]	
	.equ	OFFSET, -36		@ allocate space for the offset
@ Padding at FP_OFFSET -28 
	.equ	TEMP_BYTE_1, -8		@ allocate space for temp1
	.equ	TEMP_BYTE_2, -12	@ allocate space for temp2
	.equ	I_OFFSET, -16		@ allocate space for I
	.equ	R_MASK, -20		@ allocate space for MASK = 0xFF
	.equ	L_MASK, -24		@ allocate space for MASK =0x000000FF
@ Constants for MASK
	.equ	R_MASK_VAL, 0xFF000000	@ MASK = 0xFF000000
	.equ	L_MASK_VAL, 0x000000FF	@ MASK = 0x000000FF
	.equ	INCR, 4

	.text				@ Switch to Text segment 
	.align 2			@ Align on evenly divisible by 4 byte 
					@ address .align n where 2^n determines 
					@ alignment
/*
 * Function Name: TODO()
 * Function Prototype:TODO void set( unsigned int pattern[], unsigned int part0, 
 			unsigned int par1 );
 * Description: This function turns on the specified bits in pattern with the 
 * 		bit patterns part 0 and part1. If a bit value in part0 or part1 
 *		is 1, then its corresponding bit in pattern should also become 1
 *		However, if the bit value in part0 or part1 is 0, then its 
 *		corresponding bit in pattern should remain the same.
 * Parameters: 	pattern[] TODO the bit pattern to change, part0 and part1 the bit 
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
 *	
 * Stack variables: TODO
 *	pattern[0] - [fp -12] --  holds the memory address to pattern[] in arg 1
 *				  and the pattern[0] element.
 *	pattern[1] - [fp -8]  --  holds the pattern[1] value from arg 1
 *	part0	   - [fp -16] --  holds the bit pattern from arg 2
 *	part1      - [fp -20] --  holds the bit pattern from arg 3	
 */

scrollVertical:
@ Standard prologue
	push	{fp, lr}		@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET	@ Set fp to base of saved 
					@ registers
					@ Uses 4, from (#_of_regs_saved 
					@ - 1)*4.
@ Allocate space for the local variables
	sub	sp, sp, LOCAL_SPACE	@ allocate space for all local 
					@ variables on the stack
	str	r0, [fp, PATTERN]	@ store pattern[] on the stack
	str	r1, [fp, OFFSET]	@ store offset on the stack
@ Allocate space for the parameters 
	sub	sp, sp, PARAM_SPACE	@ allocate space for the param-
					@ eters
	mov	r3, 0			@ load 0 into r3 to initialize
					@ temp1 
	str	r3, [fp, TEMP_BYTE_1]	@ temp1 = 0;
	str	r3, [fp, TEMP_BYTE_2]	@ temp2 = 0
	str	r3, [fp, I_OFFSET]	@ store i = 0;
	ldr	r3, =R_MASK_VAL		@ load r3 with the right most
	str	r3, [fp, R_MASK]	@ byte mask and MASK = 0xFF
	ldr	r3, =L_MASK_VAL		@ load r3 with 0x000000FF to 
	str	r3, [fp, L_MASK]	@ store in left most byte mask

@ Null value check for offset to skip unecessary code execution
	ldr	r1, [fp, OFFSET]	@ get current value of offset
	cmp	r1, 0			@ if (offset == 0) exit
	beq	exit			@ exit if offset is zero

@ For loop to iterate the shifting operations the amount of times in offset
	ldr	r3, [fp, I_OFFSET]	@ get the current value of i
	mov	r2, [fp, OFFSET]	@ get the current value of offset
	cmp	r3, r2			@ while( i >= 4 )
	bge	exit_loop		@ exit the loop

loop:
@ Start body of function, check for positive or negative offset
	ldr	r1 [fp, OFFSET]		@ get value of offset
	cmp	r1, 0			@ if (offset > 0) opp. logic
	blt	negative_byte_shift	@ branch to negative byte shift
	
	ldr	r3, [fp, R_MASK]	@ get the right byte mask
	ldr	r0, [fp, PATTERN]	@ get the memory address of 
					@ pattern[]
@ Extract the first byte from pattern[0]					
	ldr	r0, [r0]		@ dereference the pattern[0] element
	and	r2, r0, r3		@ r2 = pattern[0] & MASK 
	str	r2, [fp, TEMP_BYTE_1]	@ temp1 = pattern[0] & MASK

@ Extract the first byte from pattern[1]
	ldr	r0, [fp, PATTERN]	@ get the memory address of pattern[]
	ldr	r0, [r0, INCR]		@ dereference the pattern[1]
	ldr	r3, [fp, R_MASK]	@ get the current MASK
	and	r2, r0, r3		@ r2 = pattern[1] & MASK
	str	r2, [fp, TEMP_BYTE_2]	@ temp2 = pattern[1] & MASK
@ TODO shift the pattern[0] and pattern[1] >> or << 8 bits if(offset < 0)

	
@ Loop conditional check 
	ldr	r3, [fp, I_OFFSET]	@ get the current value of i
	ldr	r2, [fp, OFFSET] 	@ get the current value of offset
	add	r3, r3, 1		@ i++
	cmp	r3, r2			@ while( i < 4)
	blt	loop			@ return to the start of loop
	
@ terminate loop
exit_loop:

exit:

@ Standard epilogue
	sub	sp, fp, FP_OFFSET		@ Set sp to top of saved regis-
						@ ters
	pop	{fp, pc}			@ Restore fp; restore lr into pc
						@ for
						@  return 
