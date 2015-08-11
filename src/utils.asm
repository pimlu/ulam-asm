	.global print, println, exit, itoa
	
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



#params: rdi: i
#returns: rax: char* (reused); rdx: length
itoa:
	push	rbx
	mov	rax, rdi
	mov	rbx, 10
	mov	rcx, 1
#count the digits in our number
.count_loop:
	cmp	rax, 10
	jb	.count_break
	
	inc	rcx
	
	mov	rdx, 0
	div	rbx
	jmp	.count_loop
.count_break:
	#rcx is now the length, store it in r8 as a backup
	mov	r8, rcx
	mov	rax, rdi
#write the digits starting at the end
.digit_loop:
	mov	rdx, 0
	div	rbx
	
	add	rdx, '0'
	dec	rcx
	mov	[numtext + rcx], dl
	jnz	.digit_loop
.digit_break:
	#put the address of the text in rax
	mov	rax, offset numtext
	#return the length and restore rbx
	mov	rdx, r8
	pop	rbx
	ret


	.data
newline:
	.ascii 	"\n"
	.bss
numtext:
	.space 32
