/*
 * Filename: character.s
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
	
	.global	character		@ Specify character as a global symbol

	.equ	PARAM_SPACE, 16		@ allocate space for the parameters
	.equ	PATTERN_OFFSET, -8	@ allocate space for the pattern[]
	.equ	CH_OFFSET, -9		@ allocate space for ch
	.equ	ALPHABET_OFFSET, -16	@ allocated space for the alphabet 
	.equ	DIGIT_OFFSET, -20	@ allocate space for the digits
	.equ	LOWER_BOUND_LETTER, 'A'	@ The lower bound of the ascii range
	.equ	UPPER_BOUND_LETTER, 'Z'	@ The upper bound for the ascii range
	.equ	LOWER_DIGIT, '0'	@ the lower case bound for digit
	.equ	UPPER_DIGIT, '9'	@ upper case bound for digit 
	.equ	INCR_OFFSET, 4		@ 4 to use as an index increment
	.text				@ Switch to Text segment 
	.align 2			@ Align on evenly divisible by 4 byte 
					@ address .align n where 2^n determines 
					@ alignment
/*
 * Function Name: character()
 * Function Prototype: int character( unsigned int pattern[], char ch, 
 *		       const char * alphabetPatterns[], const char * 
 							digitPatterns[] );
 * Description:	This function fills pattern with the bit pattern of ch. If ch 
 *		is a letter, look up its bit pattern in alphabetPatterns (upper
 *		case letters A-Z). Otherwise, if chis a number, then look up its
 *		bit pattern in digitPatterns (digits 0-9). If its bit pattern is
 *		found, use it to set the bits in pattern. 
 * Parameters:	pattern[] is the pattern with bits to display, ch is the chara-
 *		cter to display to stdout, alphabetPatters[] is the array of
 *		letter to display based on the ch, digitPatterns[] is the array
 *		of numbers to display to stdout based on ch.
 *
 * Side Effects: set the the letter or number to print to stdout and the return
 * 		 success or failure.
 * Error Conditions: None.
 * Return Value: 0 or -1.
 *
 * Registers used: 
 *	r0 - arg 1 -- ( parameter ) the address of pattern[]
 *	r1 - arg 2 -- ( parameter ) the ch character to copy pattern into array
 *	r2 - arg 3 -- ( parameter ) alphabetPatterns[] array of letter strings
 *	r3 - arg 4 -- ( parameter ) digitPatterns[] array of numbers strings.
 *
 * Stack variables: 
 *	pattern[]  	   - [fp -8]  --  holds the memory address to pattern[] 
 *	ch	   	   - [fp -9]  --  holds the parameter for ch the letter 
 *					  to copy.
 *	alphabetPatterns[] - [fp -16] --  holds the address to the array of the 
 *					  pattern strings for letters.
 *	digitPatterns[]    - [fp -20] --  holds the address to the array of 
 *					  the pattern strings for numbers.
 */

character:
@ Standard prologue
	push	{fp, lr}			@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET		@ Set fp to base of saved 
						@ registers
						@ Uses 4, from (#_of_regs_saved 
						@ - 1)*4.
	sub	sp, sp, PARAM_SPACE 		@ allocate space for the param-
						@ eters
	str	r0, [fp, PATTERN_OFFSET]	@ store pattern[] in memory
	strb	r1, [fp, CH_OFFSET]		@ store ch in memory

	str	r2, [fp, ALPHABET_OFFSET]	@ store alphabetPatterns[] in 
						@ memory
	str	r3, [fp, DIGIT_OFFSET]		@ store digitPatterns[] in mem-
						@ ory
@ Check the ch if its a letter or a digit 
	ldrsb	r0, [fp, CH_OFFSET]		@ get current value of ch
	bl	toupper				@ convert the ch to upper case
	mov	r2, r0				@ move ch into the r2 for arg3
	mov	r0, LOWER_BOUND_LETTER		@ move 'A' into r0 for arg1
	mov	r1, UPPER_BOUND_LETTER		@ move 'Z' into r1 for arg2 
	bl	intervalContains		@ intervalContains( 'A', 'Z', 
					 	@		     ch );
@ If (ch == letter ) 
	cmp	r0, 1				@ if ( ch == 1 )
	bne	else_if_digit			@ else if in the digit range

	ldrsb	r3, [fp, CH_OFFSET]		@ get the value of ch
	mov	r0, LOWER_BOUND_LETTER		@ move the 'A' into r0
	sub	r3, r3, r0			@ ch - 'A'
	ldr	r0, [fp, PATTERN_OFFSET]	@ get value of pattern[]
	ldr	r1, [fp, ALPHABET_OFFSET]
	mov	r2, INCR_OFFSET			@ load 4 into the r2 for increm
						@ menting the index
	mul	r3, r3, r2			@ r1 * 4 to get the index of the
	add	r1, r3, r1			@ alphabetPatterns[] 
	ldr	r1, [r1]			@ load the string into r1
						@ alphabetPatterns[] 
	bl	loadPatternString		@ loadPatterString( pattern[],
						@ 		, patternStr);
	mov	r0, 0				@ return 0		
	b	end				@ exit the if block
@ Check if its a letter LOWER BOUND CASE
else_if_digit:
	ldrsb	r2, [fp, CH_OFFSET]		@ get the current value of ch
	mov	r0, LOWER_DIGIT			@ move 'a' into the r0
	mov	r1, UPPER_DIGIT			@ move 'z' into the r1
	bl	intervalContains		@ intervalContains( 'a', 'z', 
						@		     ch );	
@ if ( ch == digit )
	cmp	r0, 1				@ if (ch == 1)
	bne	else				@ else its invalid input

	ldrsb	r3, [fp, CH_OFFSET]		@ get value of ch
	mov	r0, LOWER_DIGIT			@ mov '0' into the r0 
	sub	r3, r3, r0			@ ch - '0'
	ldr	r0, [fp, PATTERN_OFFSET]	@ get the value of pattern[]
	ldr	r1, [fp, DIGIT_OFFSET]		@ get the adress of digit[]
	mov	r2, INCR_OFFSET			@ load 4 into r2
	mul	r3, r3, r2			@ r1*4 to get the index of the
						@ digitPattern[] desired
	add	r1, r3, r1			@ increment the index array
	ldr	r1, [r1]			@ load the value of digit[]
	bl	loadPatternString		@ call loadPatternString with 
						@ the arguments 
	mov	r0, 0				@ return 0 for sucess
	b	end				@ exit if block

@ Else the parameter was invalid return -1	
else:
	mov	r0, -1				@ the ch is invalid return -1

end:
@ Standard epilogue
	sub	sp, fp, FP_OFFSET		@ Set sp to top of saved regis-
						@ ters
	pop	{fp, pc}			@ Restore fp; restore lr into pc
						@ for
						@  return 
