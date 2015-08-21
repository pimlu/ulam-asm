	.global txt_disp
	.include "macros.asm"
	
	.text
#draws a picture using the return values of a func.
#params: rdi: w; rsi: h; rdx: func
txt_disp:
	mov	r8, rdi
	mov	r9, rsi
	mov	r10, rdx
	#r[ds]i: x/y; r[89]: w/h; r10: func
	
	mov	rsi, 0
#loop on x and y, printing r10() each time.
.y_loop:
	mov	rdi, 0
	push	rdi
	push	rsi
.x_loop:
	#push rdi and rsi for later since our calls overwrite them
	push	rdi
	push	rsi
	
	call	r10
	mov	[curchar], al
	PRINT	curchar
	
	pop	rsi
	pop	rdi
	
	inc	rdi
	cmp	rdi, r8
	jne	.x_loop
	
	PLN
	
	pop	rsi
	pop	rdi
	
	inc	rsi
	cmp	rsi, r9
	jne	.y_loop
	
	ret

	.bss
curchar:
	.space 1
.set size_curchar, 1
