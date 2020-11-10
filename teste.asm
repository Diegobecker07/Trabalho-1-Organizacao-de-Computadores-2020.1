
.data

.text
main:
	addi s0, zero, 99
	addi sp, sp, -8
	sw s0, (sp)
	sw s0, 4(sp)
	sw s0, 8(sp)
