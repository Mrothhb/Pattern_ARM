	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"testtoggle.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"testtoggle.c\000"
	.align	2
.LC1:
	.ascii	"(%s:%d) %s:\000"
	.align	2
.LC2:
	.ascii	"pattern[0] == (pattern0 ^ 0xFFFFFFFF)\000"
	.align	2
.LC3:
	.ascii	"\011\033[32mPASSED\033[0m\012\000"
	.align	2
.LC4:
	.ascii	"\011\033[31mFAILED\033[0m\012\000"
	.align	2
.LC5:
	.ascii	"pattern[1] == (pattern1 ^ 0xFFFFFFFF)\000"
	.align	2
.LC6:
	.ascii	"pattern[0] == (pattern0 ^ 0xC)\000"
	.align	2
.LC7:
	.ascii	"pattern[1] == (pattern1 ^ 0xEEEEEEEE)\000"
	.align	2
.LC8:
	.ascii	"pattern[0] == (pattern0 ^ 0xABD)\000"
	.align	2
.LC9:
	.ascii	"pattern[1] == (pattern1 ^ 0)\000"
	.align	2
.LC10:
	.ascii	"pattern[0] == (pattern0 ^ -1)\000"
	.align	2
.LC11:
	.ascii	"pattern[1] == (pattern1 ^ 0xFAB)\000"
	.align	2
.LC12:
	.ascii	"pattern[0] == (pattern0 ^ -500)\000"
	.align	2
.LC13:
	.ascii	"pattern[1] == (pattern1 ^ BUFSIZ)\000"
	.align	2
.LC14:
	.ascii	"pattern[0] == (pattern0 ^ i)\000"
	.align	2
.LC15:
	.ascii	"pattern[1] == (pattern1 ^ j)\000"
	.text
	.align	2
	.global	testtoggle
	.syntax unified
	.arm
	.fpu vfp
	.type	testtoggle, %function
testtoggle:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	sub	r3, fp, #28
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	ldr	r3, .L64
	str	r3, [fp, #-16]
	ldr	r3, .L64+4
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-24]
	sub	r3, fp, #28
	mvn	r2, #0
	mvn	r1, #0
	mov	r0, r3
	bl	toggle
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+12
	str	r3, [sp]
	mov	r3, #39
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L5
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	cmp	r2, r3
	bne	.L3
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L52
.L3:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L52:
	nop
.L5:
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+32
	str	r3, [sp]
	mov	r3, #40
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L9
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	mvn	r3, r3
	cmp	r2, r3
	bne	.L7
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L53
.L7:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L53:
	nop
.L9:
	mov	r3, #10
	str	r3, [fp, #-16]
	ldr	r3, .L64+4
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-24]
	sub	r3, fp, #28
	ldr	r2, .L64+36
	mov	r1, #12
	mov	r0, r3
	bl	toggle
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+40
	str	r3, [sp]
	mov	r3, #51
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L13
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-16]
	eor	r3, r3, #12
	cmp	r2, r3
	bne	.L11
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L54
.L11:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L54:
	nop
.L13:
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+44
	str	r3, [sp]
	mov	r3, #52
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L17
	ldr	r2, [fp, #-24]
	ldr	r1, [fp, #-20]
	ldr	r3, .L64+36
	eor	r3, r3, r1
	cmp	r2, r3
	bne	.L15
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L55
.L15:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L55:
	nop
.L17:
	mov	r3, #123
	str	r3, [fp, #-16]
	mov	r3, #2
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-24]
	sub	r3, fp, #28
	mov	r2, #0
	ldr	r1, .L64+48
	mov	r0, r3
	bl	toggle
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+52
	str	r3, [sp]
	mov	r3, #62
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L21
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-16]
	eor	r3, r3, #2736
	eor	r3, r3, #13
	cmp	r2, r3
	bne	.L19
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L56
.L19:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L56:
	nop
.L21:
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+56
	str	r3, [sp]
	mov	r3, #63
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L25
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L23
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L57
.L23:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L57:
	nop
.L25:
	mov	r3, #0
	str	r3, [fp, #-16]
	mov	r3, #97
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-24]
	sub	r3, fp, #28
	ldr	r2, .L64+60
	mvn	r1, #0
	mov	r0, r3
	bl	toggle
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+64
	str	r3, [sp]
	mov	r3, #73
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L29
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	cmp	r2, r3
	bne	.L27
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L58
.L27:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L58:
	nop
.L29:
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+68
	str	r3, [sp]
	mov	r3, #74
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L33
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	eor	r3, r3, #4000
	eor	r3, r3, #11
	cmp	r2, r3
	bne	.L31
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L59
.L31:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L59:
	nop
.L33:
	ldr	r3, .L64+72
	str	r3, [fp, #-16]
	ldr	r3, .L64+76
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-24]
	sub	r3, fp, #28
	mov	r2, #8192
	ldr	r1, .L64+80
	mov	r0, r3
	bl	toggle
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+84
	str	r3, [sp]
	mov	r3, #84
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L37
	ldr	r2, [fp, #-28]
	ldr	r1, [fp, #-16]
	ldr	r3, .L64+80
	eor	r3, r3, r1
	cmp	r2, r3
	bne	.L35
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L60
.L35:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L60:
	nop
.L37:
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+88
	str	r3, [sp]
	mov	r3, #85
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L41
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	eor	r3, r3, #8192
	cmp	r2, r3
	bne	.L39
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L61
.L39:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L61:
	nop
.L41:
	ldr	r3, .L64+92
	str	r3, [fp, #-12]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L42
.L51:
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-12]
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-24]
	ldr	r1, [fp, #-8]
	sub	r3, fp, #28
	ldr	r2, [fp, #-12]
	mov	r0, r3
	bl	toggle
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+96
	str	r3, [sp]
	mov	r3, #95
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L46
	ldr	r2, [fp, #-28]
	ldr	r1, [fp, #-8]
	ldr	r3, [fp, #-16]
	eor	r3, r3, r1
	cmp	r2, r3
	bne	.L44
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L62
.L44:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L62:
	nop
.L46:
	ldr	r3, .L64+8
	ldr	r0, [r3]
	ldr	r3, .L64+100
	str	r3, [sp]
	mov	r3, #96
	ldr	r2, .L64+16
	ldr	r1, .L64+20
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	beq	.L50
	ldr	r2, [fp, #-24]
	ldr	r1, [fp, #-20]
	ldr	r3, [fp, #-12]
	eor	r3, r3, r1
	cmp	r2, r3
	bne	.L48
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+24
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
	bne	.L63
.L48:
	ldr	r3, .L64+8
	ldr	r3, [r3]
	ldr	r1, .L64+28
	mov	r0, r3
	bl	fprintf
	mov	r3, r0
	cmp	r3, #0
.L63:
	nop
.L50:
	ldr	r3, [fp, #-12]
	sub	r3, r3, #1
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L42:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
	bcc	.L51
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L65:
	.align	2
.L64:
	.word	-1431655766
	.word	-858993460
	.word	stderr
	.word	.LC2
	.word	.LC0
	.word	.LC1
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	-286331154
	.word	.LC6
	.word	.LC7
	.word	2749
	.word	.LC8
	.word	.LC9
	.word	4011
	.word	.LC10
	.word	.LC11
	.word	47806
	.word	1027565
	.word	-500
	.word	.LC12
	.word	.LC13
	.word	5000
	.word	.LC14
	.word	.LC15
	.size	testtoggle, .-testtoggle
	.section	.rodata
	.align	2
.LC16:
	.ascii	"Running tests for toggle...\012\000"
	.align	2
.LC17:
	.ascii	"Done running tests!\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L68
	ldr	r3, [r3]
	mov	r2, #28
	mov	r1, #1
	ldr	r0, .L68+4
	bl	fwrite
	bl	testtoggle
	ldr	r3, .L68
	ldr	r3, [r3]
	mov	r2, #20
	mov	r1, #1
	ldr	r0, .L68+8
	bl	fwrite
	mov	r3, #0
	mov	r0, r3
	pop	{fp, pc}
.L69:
	.align	2
.L68:
	.word	stderr
	.word	.LC16
	.word	.LC17
	.size	main, .-main
	.ident	"GCC: (Raspbian 6.3.0-18+rpi1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",%progbits
