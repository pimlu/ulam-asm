	.global _start
	.include "macros.asm"
	
	.text
_start:
	#check if they've put in valid args, store for later
	call	read_args
	
	mov	rsi, rdx
	mov	rdi, rax
	mov	rdx, offset ulam
	call	txt_disp
	
	#exit 0
	mov	rdi, 0
	call	exit
