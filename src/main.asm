	.global _start
	.include "macros.asm"
	
	.text
_start:
	#check if they've put in valid args, store for later
	call	read_args
	mov	r8, rax
	
	PRINT	argc_is
	
	mov	rdi, r8
	call	itoa
	mov	rdi, rax
	mov	rsi, rdx
	call	println
	

	#exit 0
	mov	rdi, 0
	call	exit
	
	.data
	STRING 	argc_is, "argc is "
