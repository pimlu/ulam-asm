	.global print, println, log_num, exit, itoa, atoi
	
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

#println a num.  rdi: i
log_num:
	call	itoa
	mov	rdi, rax
	mov	rsi, rdx
	call	println
	ret
	
#sys_exits with code. rdi: code
exit:
	mov	rax, 60
	syscall



#params: rdi: i
#returns: rax: char* (reused); rdx: length
itoa:
	mov	rax, rdi
	mov	r10, 10
	mov	rcx, 1
#count the digits in our number
.count_loop:
	cmp	rax, 10
	jb	.count_break
	
	inc	rcx
	
	mov	rdx, 0
	div	r10
	jmp	.count_loop
.count_break:
	#rcx is now the length, store it in r8 as a backup
	mov	r8, rcx
	mov	rax, rdi
	#null terminate
	mov	byte ptr [numtext + rcx], 0
#write the digits starting at the end
.digit_loop:
	mov	rdx, 0
	div	r10
	
	add	rdx, '0'
	dec	rcx
	mov	[numtext + rcx], dl
	jnz	.digit_loop
	
	#put the address of the text in rax
	mov	rax, offset numtext
	#return the length and restore rbx
	mov	rdx, r8
	ret
	
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
