/*
 * Filename: printPattern.s
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
	
	.global	printPattern		@ Specify printPattern as a global 

@ Local variables
	.equ	LOCAL_SPACE, 24		@ allocate space for the local variables
	.equ	PARAM_SPACE, 16		@ allocate space for the parameters
	.equ	CURRENT_BYTE_OFFSET, -8	@ allocate space for the current_byte
	.equ	BYTE_MASK_OFFSET, -12	@ allocate space for the BYTE_MASK
	.equ	BIT_MASK_OFFSET, -16	@ allocate space for the BIT _MASK
	.equ	I_OFFSET, -20		@ allocate space for "i"
	.equ	J_OFFSET, -24		@ allocate space for "j"

@ Formal parameters	
	.equ	PATTERN_OFFSET, -32	@ allocate space for pattern[]
	.equ	ON_OFFSET, -36		@ allocate space for char on
	.equ	OFF_OFFSET, -40		@ allocate space for char off
@ Constants 
	.equ	BITMASK, 0x80000000	@ MASK = 0x800000000;
	.equ	BYTEMASK, 0xFF000000	@ MASK = 0xFF0000000;
	.equ	BYTE_SIZE, 8		@ byte size
	.equ	FOURTH_ITER, 3		@ the fourth iteration
	.equ	NEWLINE, '\n'		@ the newline char 
	.equ	INCR, 4			@ increment for array index
	.equ	NEWLINE_OFFSET, '\n'	@ newline char for outputChar		

	.text				@ Switch to Text segment 
	.align 2			@ Align on evenly divisible by 4 byte 
					@ address .align n where 2^n determines 
					@ alignment
/*
 * Function Name: printPattern()
 * Function Prototype: void printPattern( unsigned int pattern[], char on,
 *								char off );
 * Description: Prints out the pattern as an 8x8 grid. Each bit in pattern will
 * 		be represented by a character, with each byte being a row in the
 *		grid. If the bit is 1, print on, otherwise print off.
 * Parameters: 	pattern[] the int holding a bit pattern, on the on character, 
 *		off the off character.
 * Side Effects: The pattern will be displayed on stdout.
 * Error Conditions: None.
 * Return Value: None.
 *
 * Registers used:
 *	r0 - arg 1 -- ( parameter ) the address of pattern[].
 *	r1 - arg 2 -- ( parameter ) the char on character to print.
 *	r2 - arg 3 -- ( parameter ) the char off character to print.
 *	r3 - instr -- used for computational operations and temp for storage 
 *  		      during loads and stores to memory.
 *	
 * Stack variables:
 *	byte_mask	--  The byte mask for extracting a byte from pattern. 
 *	current_byte	--  The current temp byte extracted from pattern.
 *	bit_mask	--  The bit mask to extract a bit from the byte.
 *	i		--  The increment variable for byte loop.
 *	j		--  The increment variable for bit loop.
 *	pattern[]	--  The pattern array of bits.
 *	on		--  The char on character to print to stdout.
 *	off		--  The char of character to print to stdout.	
 */

printPattern:
@ Standard prologue
	push	{fp, lr}			@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET		@ Set fp to base of saved 
						@ registers
						@ Uses 4, from (#_of_regs_saved 
						@ - 1)*4.
@ allocate space for the local variables
	sub	sp, sp, LOCAL_SPACE		@ allocate space for local 
						@ variables
	ldr	r3, =BYTEMASK			@ load 0x80000000 into r3
	str	r3, [fp, BYTE_MASK_OFFSET]	@ store MASK in memory
	ldr	r3, =BITMASK			@ load the bit mask
	str	r3, [fp, BIT_MASK_OFFSET]	@ store the bitmask in memory
						@ i = 0;

@ allocate space for the formal paramters
	sub	sp, sp, PARAM_SPACE		@ allocate space for parameters

	str	r0, [fp, PATTERN_OFFSET]	@ store pattern[] in memory
	str	r1, [fp, ON_OFFSET]		@ store char 'on' in memory
	str	r2, [fp, OFF_OFFSET]		@ store char 'off' on the stack

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 	BYTE LOOP  	for ( i = 0; i < 8; i++){
@			  if (i < 3)
@			    current_byte = pattern[0] & byte_mask;
@			  else
@			    current_byte = pattern[1] & byte_mask;
@			 }
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	mov	r3, 0				@ load 0 into r3
	str	r3, [fp, I_OFFSET]		@ store i with value 0 on stack 
	ldr	r3, [fp, I_OFFSET]		@ get the current value of i
	cmp	r3, BYTE_SIZE			@ while( i >= 8 )
	bge	end_byte_loop			@ exit the loop

byte_loop:
	ldr	r3, [fp, I_OFFSET]		@ get the current value of I
@ if( i <= 3) opp logic 		
	cmp	r3, FOURTH_ITER			@ if ( i > 3 )
	bgt	load_pattern_1			@ load pattern[1] for operations

load_pattern_0:	
@ if ( i < 3 ) current_byte = pattern[0] & byte_mask;
	ldr	r3, [fp, PATTERN_OFFSET]	@ get the address of pattern[]
	ldr	r3, [r3]			@ dereference pattern[0]
	ldr	r0, [fp, BYTE_MASK_OFFSET]	@ get the byte_mask
	and	r0, r3, r0			@ current_byte = pattern[0] & 
						@ byte_mask
	str	r0, [fp, CURRENT_BYTE_OFFSET]	@ store the current byte with 
	b	end_load_pattern_0		@ new value
						
@ Else 
load_pattern_1:
@ else current_byte = pattern[1] & byte_mask;	
	ldr	r3, [fp, PATTERN_OFFSET]	@ get the address of pattern[]
	add	r3, r3, INCR			@ get the address of pattern[1]
	ldr	r3, [r3]			@ dereference pattern[1]
	ldr	r0, [fp, BYTE_MASK_OFFSET]	@ get the byte_mask
	and	r0, r3, r0			@ current byte = pattern[1] &
						@ byte_mask
	str	r0, [fp, CURRENT_BYTE_OFFSET]	@ store the current byte with 
						@ new value
end_load_pattern_0:						

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 	BIT LOOP 	for(j = 0; j < 8; j ++) {
@			  current_byte = current_byte & bit_mask;
@			    if( current_byte  == 0 )
@			      outputChar(off);
@			    else { outputChar(on);
@			  bit_mask = bit_mask >> 8;
@			}
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	mov 	r3, 0				@ initialize the variable j = 0;
	str	r3, [fp, J_OFFSET]		@ store the value of j 
	ldr	r3, [fp, J_OFFSET]		@ get the current value of j
	cmp	r3, BYTE_SIZE			@ for( i >= 8 )
	bge	end_bit_loop			@ branch to the end of the loop

bit_loop:
@ extract the first bit
	ldr	r3, [fp, CURRENT_BYTE_OFFSET]	@ get the current_byte
	ldr	r0, [fp, BIT_MASK_OFFSET]	@ get the bit_mask
	and	r3, r3, r0			@ current_byte = current_byte &
						@ bit_mask

@ if( current_byte == 0) --> print(off) else --> print(on)
	cmp	r3, 0				@ if(current_byte != 0)
	bne	print_on			@ print the on char

	ldr	r0, [fp, OFF_OFFSET]		@ get the curent value of 'off'
	bl	outputChar			@ outputChar(off)
	b	done_print_off			@ branch over print_on 

print_on:
	ldr	r0, [fp, ON_OFFSET]		@ get the current value of 'off'
	bl	outputChar			@ outputChar(off);

done_print_off:

	ldr	r3, [fp, BIT_MASK_OFFSET]	@ get the current bit mask
	lsr	r3, r3, 1			@ bit_mask = bit_mask >> 1;
	str	r3, [fp, BIT_MASK_OFFSET]	@ store the new bit_mask

@ loop condition check for bit_mask
	ldr	r3, [fp, J_OFFSET]		@ get the value of j
	add	r3, r3, 1			@ add one to ++j
	str	r3, [fp, J_OFFSET]		@ store the current value of j
	cmp	r3, BYTE_SIZE			@ while( i < 8 )
	blt	bit_loop			@ re enter the loop

end_bit_loop:
	
@ Print the newline after each byte
	mov	r0, NEWLINE_OFFSET		@ move the newline char 
	bl	outputChar			@ outputChar('\n')

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@	byte_mask = byte_mask  >> 8;
@	if ( i == 3 )
@	  byte_mask = 0xFF000000; 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	ldr	r3, [fp, BYTE_MASK_OFFSET]	@ get the byte_mask 
	lsr	r3, r3, BYTE_SIZE		@ lsr 8 times on the byte mask
	str	r3, [fp, BYTE_MASK_OFFSET]	@ store the new byte_mask
	ldr	r0, [fp, I_OFFSET]		@ get the value of i
	cmp	r0, FOURTH_ITER			@ if (!(i == 3))

	bne	byte_loop_condition		@ branch back into loop
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@	Resest the bit_mask and byte_mask
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	ldr	r3, =BYTEMASK			@ load r3 with bytemask
	str	r3, [fp, BYTE_MASK_OFFSET]	@ byte_mask = 0xFF000000;
	ldr	r3, =BITMASK			@ load the value of bitmask
	str	r3, [fp, BIT_MASK_OFFSET]	@ bit_mask = 0x800000000;

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ 	Byte Loop condition check 
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
byte_loop_condition:
	ldr	r3, [fp, I_OFFSET]		@ get the current value of i
	add	r3, r3, 1			@ i = i +1
	str	r3, [fp, I_OFFSET]		@ store the value of i
	ldr	r3, [fp, I_OFFSET]		@ get the value of i
	cmp	r3, BYTE_SIZE			@ while( i < 8 )
	blt	byte_loop			@ re enter the loop

end_byte_loop:
	
@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp, pc}		@ Restore fp; restore lr into pc
					@ for return 
