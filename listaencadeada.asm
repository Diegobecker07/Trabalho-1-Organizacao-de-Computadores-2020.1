	.globl main
	.data
vetor:	.word
msg_opc:	.string "Digite uma opcao"
quebra_linha:	.string "\n"
msp_opc_1:	.string "1 - Inserir elemento"
msp_opc_2:	.string "2 - Remover elemento"
msp_opc_3:	.string "3 - Consultar elemento"
msp_opc_4:	.string "4 - Verificar elemento"
msp_opc_5:	.string "5 - Sair"
msg_vet:	.string "Vetor: "
	.text
main:
	
	j lista_opcoes

lista_opcoes: #faz chamada para listar todos os elementos que podem ser chamados
	la a0, msg_opc
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_1
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_2
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_3
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_4
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	la a0, msp_opc_5
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li sp, 5
	add t3, t3, sp
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	j end
	
end:
	nop
	ebreak
