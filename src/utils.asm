	.global print, println, exit, atoi
	
	.text
#sys_writes to stdout.
#rdi: char*; rsi: length
print:
	mov	rdx, rsi
	mov	rsi, rdi
	mov	rax, 1
	mov	rdi, 1
	syscall
	ret
	
println:
	cmp	rsi, 0
	jz	.skip_print
	call	print
.skip_print:
	mov	rdi, offset newline
	mov	rsi, 1
	call	print
	ret
	
#sys_exits with code. rdi: code
exit:
	mov	rax, 60
	syscall
	
#params: rdi: char*
#returns: rax: i
atoi:
	mov	rax, 0
	mov	r10, 10
	mov	rcx, 0
#walk forward, mul by 10 and add digit each step
.mul_loop:
	mov	rdx, 0
	mov	dl, byte ptr [rdi + rcx]
	#give up when non-digit
	cmp	rdx, '0'
	jb	.mul_break
	cmp	rdx, '9'
	jg	.mul_break
	sub	rdx, '0'
	#stored because mul writes to rdx
	mov	rsi, rdx
	
	mul	r10
	
	add	rax, rsi
	inc	rcx
	jmp	.mul_loop
.mul_break:
	ret
	.data
newline:
	.ascii 	"\n"
	.bss
numtext:
	.space 32
