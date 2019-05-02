/*
 * Filename: scrollVertical.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53		@ Version of our Pis
	.syntax	unified			@ Modern ARM syntax

	.equ	FP_OFFSET, 4		@ Offset from sp to set fp
	
	.global	scrollVertical		@ Specify scrollVertical as a global 
					@ symbol
	.equ	LOCAL_SPACE, 28		@ allocate space for the local variables
	.equ	PARAM_SPACE, 8		@ allocate space for the parameters
	.equ	PATTERN, -32		@ allocate space for pattern[]	
	.equ	OFFSET, -36		@ allocate space for the offset

	.equ	TEMP_BYTE_1, -8		@ allocate space for temp1
	.equ	TEMP_BYTE_2, -12	@ allocate space for temp2
	.equ	I_OFFSET, -16		@ allocate space for I
	.equ	R_MASK, -20		@ allocate space for MASK = 0xFF
	.equ	L_MASK, -24		@ allocate space for MASK =0x000000FF
	.equ	IS_NEGATIVE, -28	@ allocate space for is_negative;

@ Constants
	.equ	R_MASK_VAL, 0xFF000000	@ MASK = 0xFF000000
	.equ	L_MASK_VAL, 0x000000FF	@ MASK = 0x000000FF
	.equ	INCR, 4			@ The increment for 'i'
	.equ	BYTE_SIZE, 8		@ The amount of bits to shift '8'
	.equ	THREE_BYTE_SHIFT, 24	@ Shift by 24 bits 

	.text				@ Switch to Text segment 
	.align 2			@ Align on evenly divisible by 4 byte 
					@ address .align n where 2^n determines 
					@ alignment
/*
 * Function Name: scrollVertical()
 * Function Prototype: void scrollVertical( unsigned int pattern[], int offset);
 * Description: Scroll patternvertically based on offset. If offsetis positive, 
 * 		scroll down and wrap the bits around to the top. If offset is 
 * 		negative, scroll up and wrap the bits around to the bottom.
 * Parameters: 	pattern[] the array of bit patterns, offset the amount of times
 *		to shift the pattern.
 * Side Effects: Shift the pattern image up or down vertically.
 * Error Conditions: None.
 * Return Value: None.
 *
 * Registers used:
 *	r0 - arg 1 -- ( parameter ) the address of pattern[].
 *	r1 - arg 2 -- ( parameter ) the offset to shift the pattern.
 *	r2 - instr -- used for operations and temp holding values.
 *	r3 - instr -- used for computational operations and temp for storage 
 *  		      during loads and stores to memory.
 *	
 * Stack variables:
 *	pattern[] - [fp -32]  --  holds the memory address to pattern[].
 *	offset    - [fp -36]  --  holds the offset to shift pattern.
 *	temp1	  - [fp -8 ]  --  holds the temp1 for bit extraction/insertion.
 *	temp2	  - [fp -12]  --  holds the temp2 for bit extraction/insertion.
 *	i	  - [fp -16]  --  holds the iterator for the loop.
 *	r_mask    - [fp -20]  --  holds the right most byte mask.
 *	l_mask    - [fp -24]  --  holds the left most byte mask.
 *	is_negative-[fp -28]  --  holds the conditional for negative branching.
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
	ldr	r1, [fp, OFFSET]	@ get the current value of offset

@ find out if offset is negative 
	cmp	r1, 0			@ if( offset < 0)
	bgt	positive_offset		@ branch to the positive case 

@ offset is less than zero get the amount times to iterate

	mov	r0, -1			@ move -1 as a flip for the offset 
	mul	r1, r1, r0		@ multiply the offset by -1 to get an
					@ iterator value for the loop
	str	r1, [fp, OFFSET]	@ store the new offset value 
	mov	r0, -1			@ use -1 as a conditional flag for 
					@ determining which function to use
	str	r0, [fp, IS_NEGATIVE]	@ store the conditional flag in a local
					@ variable negative = -1;

@ Positive offset, leave the offset value as is 
positive_offset:

	ldr	r3, [fp, I_OFFSET]	@ load I into r3
	cmp	r3, r1			@ while( i >= offset)
	bge	exit			@ exit the loop if i >= offset

@ Loop begins to iterate and shift the pattern offset amount of times 
loop:
@ Start body of function, check for positive or negative offset

	ldr	r1, [fp, IS_NEGATIVE]	@ load the conditional flag 
	cmp	r1, 0			@ if ( offset > 0 ) opp. logic
	bgt	negative_offset		@ use branch to negative byte shifting 

@@ POSITIVE OFFSET BLOCK	
	ldr	r3, [fp, R_MASK]	@ get the right byte mask
	ldr	r0, [fp, PATTERN]	@ get the memory address of 
					@ pattern[]
@ Extract the first byte from pattern[0]					

	ldr	r0, [r0]		@ dereference the pattern[0] element
	and	r2, r0, r3		@ r2 = pattern[0] & MASK 
	lsr	r2, THREE_BYTE_SHIFT	@ Shift the leftmost byte to rightmost
	str	r2, [fp, TEMP_BYTE_1]	@ temp1 = pattern[0] & MASK

@ Extract the first byte from pattern[1]

	ldr	r0, [fp, PATTERN]	@ get the memory address of pattern[]
	ldr	r0, [r0, INCR]		@ dereference the pattern[1]
	ldr	r3, [fp, R_MASK]	@ get the current MASK
	and	r2, r0, r3		@ r2 = pattern[1] & MASK
	lsr	r2, THREE_BYTE_SHIFT	@ shift leftmost byte to rightmost byte
	str	r2, [fp, TEMP_BYTE_2]	@ temp2 = pattern[1] & MASK

@ temp1 and temp2 have been initialized and stored in memory  
	
@ Shift the pattern[0] and pattern[1] >> for positive offset

@ Insert the temp2 byte back into pattern[0]

	ldr	r0, [fp, PATTERN]	@ get the memory address of pattern[]
	ldr	r0, [r0]		@ dereference pattern[0]
	ldr	r3, [fp, TEMP_BYTE_2]	@ Get the current value of temp2	
	lsl	r0, BYTE_SIZE		@ logical shift right 8 times
	orr	r0, r0, r3		@ pattern[0] | temp2
	ldr	r1, [fp, PATTERN]	@ get the memory address of pattern[0]
	str	r0, [r1]		@ pattern[0] = pattern[0] | temp

@ Insert the temp1 byte back into pattern[1]	

	ldr	r0, [fp, PATTERN]	@ get the memory address of pattern[]
	add	r0, r0, INCR		@ get the memory address of pattern[1]
	ldr	r0, [r0]		@ dereference pattern[1]
	ldr	r3, [fp, TEMP_BYTE_1]	@ get the current value of temp1	
	lsl	r0, BYTE_SIZE		@ logical shift right pattern[1] >>
	orr	r0, r0, r3		@ pattern[1] | temp1
	ldr	r1, [fp, PATTERN]	@ get the memory address of pattern[]
	add	r1, r1, INCR		@ get the memory address of pattern[1]
	str	r0, [r1]		@ pattern[1] = pattern[1] | temp1

	b	loop_conditional_check	@ branch to the loop conditional check

@@ NEGATIVE OFFSET OFFSET BLOCK 
negative_offset:
	ldr	r3, [fp, L_MASK]	@ get the left byte mask 
	ldr	r0, [fp, PATTERN]	@ get the memory ddress of pattern[]

@ Extract the first byte from pattern[0]

	ldr	r0, [r0]		@ dereference pattern[0] 
	and	r2, r0, r3		@ r2 = pattern[0] & MASK
	lsl	r2, THREE_BYTE_SHIFT	@ shift rightmost byte to leftmost byte
	str	r2, [fp, TEMP_BYTE_1]	@ temp1 = pattern[0] & MASK

@ Extract the first byte from pattern[1]

	ldr	r0, [fp, PATTERN]	@ get the memory address of pattern[]
	ldr	r0, [r0, INCR]		@ dereference the pattern[1]
	ldr	r3, [fp, L_MASK]	@ get the current MASK
	and	r2, r0, r3		@ r2 = pattern[1] & MASK
	lsl	r2, THREE_BYTE_SHIFT	@ shift leftmost byte rightmost byte
	str	r2, [fp, TEMP_BYTE_2]	@ temp2 = pattern[1] & MASK

@ temp1 and temp2 now have been initialized and stored in memory

@ Shift the pattern[0] and pattern[1] << for negative offset

@ Insert the temp2 byte back into pattern[0]

	ldr	r0, [fp, PATTERN]	@ get the memory address of pattern[]
	ldr	r0, [r0]		@ dereference pattern[0]
	ldr	r3, [fp, TEMP_BYTE_2]	@ Get the current value of temp2	
	lsr	r0, BYTE_SIZE		@ logical shift right 8 times
	orr	r0, r0, r3		@ pattern[0] | temp2
	ldr	r1, [fp, PATTERN]	@ get the memory address of pattern[0]
	str	r0, [r1]		@ pattern[0] = pattern[0] | temp

@ Insert the temp1 byte back into pattern[1]	

	ldr	r0, [fp, PATTERN]	@ get the memory address of pattern[]
	add	r0, r0, INCR		@ get the memory address of pattern[1]
	ldr	r0, [r0]		@ dereference pattern[1]
	ldr	r3, [fp, TEMP_BYTE_1]	@ get the current value of temp1	
	lsr	r0, BYTE_SIZE		@ logical shift right pattern[1] >>
	orr	r0, r0, r3		@ pattern[1] | temp1
	ldr	r1, [fp, PATTERN]	@ get the memory address of pattern[]
	add	r1, r1, INCR		@ get the memory address of pattern[1]
	str	r0, [r1]		@ pattern[1] = pattern[1] | temp1

	b	loop_conditional_check	@ branch to the loop conditional check
		
@ Loop conditional check
loop_conditional_check:

	ldr	r3, [fp, I_OFFSET]	@ get the current value of i
	ldr	r1, [fp, OFFSET] 	@ get the current value of offset
	add	r3, r3, 1		@ i++
	str	r3, [fp, I_OFFSET]	@ save the new value of i++
	
#positive_condition:
	ldr	r3, [fp, I_OFFSET]	@ get the current value of i
	cmp	r3, r1			@ while( i < offset )
	blt	loop			@ return to the start of loop
	
@ terminate loop and exit the function 
exit:

@ Standard epilogue
	sub	sp, fp, FP_OFFSET		@ Set sp to top of saved regis-
						@ ters
	pop	{fp, pc}			@ Restore fp; restore lr into pc
						@ for
						@  return 
