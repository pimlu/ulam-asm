	.global _start
	.include "macros.asm"
	
	.text
_start:
	#check if they've put in valid args, store for later
	call	read_args
	mov	r8, rax
	mov	r9, rdx
	
	PRINT	width_is
	
	mov	rdi, r8
	call	log_num
	
	PRINT	height_is
	mov	rdi, r9
	call	log_num
	
	#exit 0
	mov	rdi, 0
	call	exit
	
	.data
	STRING 	width_is, "width is: "
	STRING 	height_is, "height is: "
