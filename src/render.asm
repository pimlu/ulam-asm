	.global ulam
	
	.text

	
.macro PUSHREGS
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	r8
	push	r9
	push	r10
	push	r11
.endm
.macro POPREGS
	pop	r11
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
ulam:
	PUSHREGS
	
	#center coordinates based on w/h
	mov	rax, r8
	shr	rax
	sub	rdi, rax
	
	mov	rax, r9
	shr	rax
	sub	rsi, rax
	
	#rdi and rsi are center x and y
	
	#put an o at the center
	mov	al, 'o'
	mov	r10, rdi
	or	r10, rsi
	test	r10, r10
	jz	.return
	
	#find out what number it is
	call	spiral
	
	#check if prime, and output a # if so
	mov	rdi, rax
	call	isprime
	
	test	rax, rax
	mov	al, '.'
	jz	.return
	
	mov	al, '#'
	
.return:
	
	POPREGS
	ret

.macro ABS	dst, src
	mov	rax, \src
	cqo
	xor	rax, rdx
	sub	rax, rdx
	mov	\dst, rax
.endm
#finds the nearest square number and calculates its offset from that, so we know where
#it is on the ulam spiral
#params: r[ds]i: x/y (destructive)
#returns: rax: num
spiral:
#function spiral(x,y) {
#  var dist = Math.max(Math.abs(x),Math.abs(y));
	#rbx: dist (using r10 and r11 for abs)
	ABS	r10, rdi
	
	ABS	r11, rsi
	
	mov	rbx, r10
	cmp	r10, r11
	jg	.smaller
	mov	rbx, r11
.smaller:
#  var sqr = dist*2
	#sqr: r10
	sal	rbx
	mov	r10, rbx
#  var ret = -x-y+1;
	#ret: r11
	mov	r11, rsi
	neg	r11
	sub	r11, rdi
	inc	r11
#  if(x-y<=0) {
	mov	rdx, rdi
	sub	rdx, rsi
	cmp	rdx, 0
	jg	.skip_half
#    ret--;
	dec	r11
#    ret *= -1;
	neg	r11
#    sqr++;
	inc	r10
#  }
.skip_half:
#  ret -= dist*2;
	sub	r11, rbx
#  ret += sqr*sqr;
	imul	r10, r10
	add	r11, r10
#  return ret;
	mov	rax, r11
#}
	ret

#rdi: n
#rax: if it's prime
isprime:
	cmp	rdi, 2
	jle	.composite
	
	mov	rcx, 2
.div_loop:
	
	mov	rax, rdi
	mov	rdx, 0
	idiv	rcx
	
	test	rdx, rdx
	jz	.composite
	
	inc	rcx
	cmp	rcx, rdi
	jne	.div_loop
	
	mov	rax, 1
	ret
.composite:
	mov	rax, 0
	ret
