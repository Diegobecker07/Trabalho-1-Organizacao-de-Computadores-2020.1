.data
	vector: .word 5,9,3,8,5,7
.text
main:
	la a0, vector
	lw t0,0(a0)
	add a2,zero,t0
	addi a1,zero,6
	addi t1, zero,0
	j search
search:
	beq t1,a1, end
	lw t0, (a0)
	bge a2,t0,menor
	j adi1
adi1:
	addi t1,t1,1
	addi a0,a0,4
	j search
menor:
	add a2,zero, t0
	add s0,zero, t1
	j adi1
end:
	add a1, zero,a2
	add a0, zero,s0
	nop
	ebreak