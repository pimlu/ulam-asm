	.global	_start

	.text
_start:
	#say hello
	lea	rdi, [message]
	mov	rsi, offset msg_size
	call	print

	#exit 0
	mov	rdi, 0
	call	exit
	
	.data
message:
	.ascii	"Hello, world\n"
	.set msg_size, .-message
