#dumps a string and its size/
.macro STRING	symbol, text
\symbol:
	.ascii	"\text"
	.set	size_\symbol, .-\symbol
.endm

#prints a string and its size
.macro PRINT	symbol
	mov	rdi, offset \symbol
	mov	rsi, offset size_\symbol
	call	print
.endm
.macro PRINTLN	symbol
	mov	rdi, offset \symbol
	mov	rsi, offset size_\symbol
	call	println
.endm
.macro PLN
	mov	rsi, 0
	call	println
.endm
