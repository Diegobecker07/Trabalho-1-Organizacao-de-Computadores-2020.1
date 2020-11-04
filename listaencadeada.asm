	.globl main
	.data
msg_opc:	.string "Digite uma opcao"
quebra_linha:	.string "\n"
msp_opc_1:	.string "1 - Inserir elemento"
msp_opc_2:	.string "2 - Remover elemento por indice"
msp_opc_3:	.string "3 - Remover elemento por valor"
msp_opc_4:	.string "4 - Listar elementos da lista"
msp_opc_5:	.string "5 - Sair"
msg_vet:	.string "Vetor: "
msg_vet1:	.string "Vetor: "
msg_vet2:	.string "Vetor: "
msg_vet3:	.string "Vetor: "
space:		.string " "
space1:		.string " "
space2:		.string " "
msg_valor_erro: .string "Valor digitado invalido insiva novamente um valor valido"
msg_qual_valor: .string "Digite o valor a ser inserido na lista"
msg_erro_inser: .string "Nao foi possivel inserir o valor na lista"

vetor:	.word 1, 3
	.text
main:
	la t5, vetor	#carrega o end inicial do vetor em t5
	addi a3, zero, 6
	j lista_opcoes

lista_opcoes: #faz chamada para listar todos os elementos que podem ser chamados
	addi t6, zero, 1
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
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	add t3, zero, a0 #move valor do teclado para t3
	beq t3, t6, insere_elemento
	addi t6, t6, 1		#gambiarra p/ usar so um registrador e verificar se o numero digitado
	beq t3, t6, remover_por_indice	#e igual ao ao que esta no reg, toda vez sendo somado
	addi t6, t6, 1
	beq t3, t6, remover_por_valor
	addi t6, t6, 1
	beq t3, t6, listar_elementos
	addi t6, t6, 1
	beq t3, t6, end
	la a0, msg_valor_erro #caso o valor nao seja da lista informada, 
	li a7, 4		#ele dá erro e manda inserir novamente
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j main
	
insere_elemento:
	la a0, msg_qual_valor
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5	#pega valor digitado do teclado para armazenar na lista
	ecall
	
	
	j lista_opcoes

remover_por_indice:
	j end
	
remover_por_valor:
	j end

listar_elementos:
	la a0, msg_vet
	li a7, 4
	ecall
	lw t1, (t5)
	add a0, t1, zero
	li a7, 1
	ecall
	la a0, space
	li a7, 4
	ecall
	addi a4, a4, 1
	slli a4, a4, 2
	lw t0, (a4)
	
end:
	nop
	ebreak
