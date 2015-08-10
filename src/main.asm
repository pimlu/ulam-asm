	.global	_start

	.text
_start:
	mov	rdi, offset magic
	mov	rsi, offset magic_size
	call	print
	
	mov	rdi, 1234
	call	itoa
	mov	rdi, rax
	mov	rsi, rdx
	call	println
	

	#exit 0
	mov	rdi, 0
	call	exit
	
	.data
magic:
	.ascii	"The magic number is: "
	.set magic_size, .-magic
