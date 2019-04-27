/*
 * Filename: outputChar.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: April 17, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53	@ Version of our Pis
	.syntax	unified		@ Modern ARM syntax

	.equ	FP_OFFSET, 4	@ Offset from sp to set fp
	
	.section .rodata	@ ROData asm directive for .rodata
fmt:	.asciz "%c"		@ The character to format 

	.global	outputChar	@ Specify outputChar as a global symbol

	.text			@ Switch to Text segment 
	.align 2		@ Align on evenly divisible by 4 byte address;

				@   .align n where 2^n determines alignment
/*
 * Function Name: outputChar()
 * Function Prototype: void outputChar( char ch );
 * Description: This assembly module prints a single character ch to stdout.
 * Parameters: ch - the character to display
 * Side Effects: None
 * Error Conditions: argument is more than one character will produce error. 
 * Return Value: None.
 *
 * Registers used:
 *	r0 - arg 1 -- the char parameter and the fmt: char to display
 *	r1 - arg 2 -- the char to display
 */

outputChar:
@ Standard prologue
	push	{fp, lr}		@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET	@ Set fp to base of saved registers
					@ Uses 4, from (#_of_regs_saved - 1)*4.

	mov	r1, r0			@ Moves char param to arg2 
	ldr	r0, =fmt		@ Get address of format string.
	bl	printf	 		@ Calls printf("%c", fmt); 

@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp, pc}		@ Restore fp; restore lr into pc for
					@  return 
