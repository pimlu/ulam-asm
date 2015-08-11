	.global read_args
	.include "macros.asm"
	
	.text
#validates (and returns) args.  exits otherwise.
read_args:
	#read argc
	mov	rax, 0
	mov	eax, [rsp+8]
	cmp	rax, 3
	jne	.fail_argc
	
	ret
.fail_argc:
	dec	rax
	mov	rdi, rax
	call	itoa
	#store the result for later
	mov	r8, rax
	mov	r9, rdx
	
	PRINT	argc_msg
	
	mov	rdi, r8
	mov	rsi, r9
	call	println
	
	mov	rdi, 1
	call	exit
	
	.data
	STRING	argc_msg "You must provide 2 arguments.  Number given: "
