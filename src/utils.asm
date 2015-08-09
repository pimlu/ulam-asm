	.global print, exit
	
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
#sys_exits with code. rdi: code
exit:
	mov	rax, 60
	syscall
