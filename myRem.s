/*
 * Filename: myRem.s
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
	
	.global	myRem		@ Specify myRem as a global symbol

	.text			@ Switch to Text segment 
	.align 2		@ Align on evenly divisible by 4 byte address;

				@   .align n where 2^n determines alignment
/*
 * Function Name: myRem()
 * Function Prototype: int myRem( int dividend, int divisor );
 * Description:  Calculates the remainder when dividing dividend by divisor
 * 		 This should have the same behavior as the % operator in C.
 * Parameters: dividend - the dividend of expression.
 *	       divisor - the divisor of experssion.	
 * Side Effects: None
 * Error Conditions: divisor is zero --- result is undefined 
 * Return Value: The remainder
 *
 * Registers used:
 *	r0 - arg 1 -- the dividend of the expression.
 *	r1 - arg 2 -- the divisor of the expression.
 *	r2 - local var -- the quotient.
 *	r3 - local var -- temp holder for result of multiplication.
 */

myRem:
@ Standard prologue
 	push	{fp, lr}		@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET	@ Set fp to base of saved registers
					@ Uses 4, from (#_of_regs_saved - 1)*4.
	
	sdiv	r2, r0, r1		@ quotient (r2) = dividend (r0) 
					@ / divisor(r1)
	mul	r3, r2, r1		@ tmpRes(r3) = quotient(r2)*divisor(r1)
	sub	r0, r0, r3		@ remainder(r2)=dividend(r0)-tmpRes(r3)

@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp, pc}		@ Restore fp; restore lr into pc for
					@ return 
