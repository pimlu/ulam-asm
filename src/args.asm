	.global read_args
	.include "macros.asm"
	
	.text
#validates (and returns) args.  exits otherwise.
#returns: rax: x; rdx: y
read_args:
	#read argc
	mov	rax, [rsp+8]
	cmp	rax, 3
	jne	.fail_argc
	
	#now read our two args, argv[1] and [2]
	mov	rdi, [rsp+2*8 + 1*8]
	call	atoi
	mov	r8, rax
	
	mov	rdi, [rsp+2*8 + 2*8]
	call	atoi
	mov	rdx, rax
	mov	rax, r8
	
	ret
.fail_argc:
	
	PRINTLN	argc_msg
	
	mov	rdi, 1
	call	exit
	
	.data
	STRING	argc_msg "bad args"
