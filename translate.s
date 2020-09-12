/*
 * Filename: translate.s
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
	
	.global	translate		@ Specify translate as a global 
					@ symbol
	.equ	PARAM_SPACE, 16		@ allocate space for the parameters
	.equ	PATTERN, -8		@ allocate space for pattern[]	
	.equ	H_OFFSET, -12		@ allocate space for hOffset
	.equ	V_OFFSET, -16		@ allocate space for vOffset
@ Constants
	.equ	INCR, 4			@ The increment for pattern[]

	.text				@ Switch to Text segment 
	.align 2			@ Align on evenly divisible by 4 byte 
					@ address .align n where 2^n determines 
					@ alignment
/*
 * Function Name: translate()
 * Function Prototype: void translate( unsigned int pattern[], int hOffset, 
 *								int vOffset ); 
 * Description: Translates pattern horizontally with hOffset and vertically with
 *		vOffset. A translation is the same as scrolling the image, but 
 *		scrolling can go in both directions (horizontal and vertical).
 * Parameters: 	pattern[] the array of bit patterns, hOffset the horizontal 
 *		shift, vOffset the vertical shift.
 * Side Effects: Shift the pattern image horizontally and vertically. 
 * Error Conditions: None.
 * Return Value: None.
 *
 * Registers used: 
 *	r0 - arg 1 -- ( parameter ) the address of pattern[].
 *	r1 - arg 2 -- ( parameter ) the hOffset paramteter.
 *	r2 - arg 3 -- ( parameter ) the vOffset parameter.
 *	
 * Stack variables: 
 *	pattern[] - [fp -8]  --  holds the memory address to pattern[].
 *	hOffset   - [fp -12] --  holds the offset for horiztonal shift.
 *	vOffset   - [fp,-16] --  holds the offset for vertical shift.
 */	

translate:
@ Standard prologue
	push	{fp, lr}		@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET	@ Set fp to base of saved 
					@ registers
					@ Uses 4, from (#_of_regs_saved 
					@ - 1)*4.

@ Allocate space for the parameters 

	sub	sp, sp, PARAM_SPACE	@ allocate space for the parameters
	str	r0, [fp, PATTERN]	@ store pattern[]
	str	r1, [fp, H_OFFSET]	@ store int hOffset;
	str	r2, [fp, V_OFFSET]	@ store int vOffset;

@ Shift horizontally
	ldr	r0, [fp, PATTERN]	@ get the adress of pattern[]
	ldr	r1, [fp, H_OFFSET]	@ get the offset for horizontal shift
	bl	scrollHorizontal	@ call scrollHorizontal( pattern, 
					@ 	offset);
@ Shift vertically
	ldr	r0, [fp, PATTERN]	@ get the address of pattern
	ldr	r1, [fp, V_OFFSET]	@ get the vertical offset
	bl	scrollVertical		@ call scrollVertical( pattern, offset);

@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp, pc}		@ Restore fp; restore lr into pc
					@ for return
