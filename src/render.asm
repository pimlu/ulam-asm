	.global pound, circ
	
	.text
pound:
	mov	rax, '#'
	ret

	
.macro PUSHREGS
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	r8
	push	r9
	push	r10
.endm
.macro POPREGS
	pop	r10
	pop	r9
	pop	r8
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
.endm
	
#params: r[ds]i: x/y; r[89]: w/h;
#returns: rax: char
circ:
	PUSHREGS
	
	mov	rax, r8
	shr	rax
	sub	rdi, rax
	
	mov	rax, r9
	shr	rax
	sub	rsi, rax
	
	imul	rdi, rdi
	imul	rsi, rsi
	add	rdi, rsi
	
	mov	al, '.'
	
	cmp	rdi, 5*5
	jge	.empty
	
	mov	al, '#'
	
.empty:
	
	
	POPREGS
	ret
