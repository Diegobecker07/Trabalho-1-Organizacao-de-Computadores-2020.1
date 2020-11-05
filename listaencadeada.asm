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
space1:		.string "abc"
space2:		.string " "
msg_valor_erro: .string "Valor digitado invalido insiva novamente um valor valido"
msg_qual_valor: .string "Digite o valor a ser inserido na lista"
msg_erro_inser: .string "Nao foi possivel inserir o valor na lista"

vetor:	.word
	.text
main:
	la s0, vetor	#carrega o end inicial do vetor em s0
	la s1, vetor	#carrega o end inicial do vetor em s1 para incrementar futuras insercoes
	addi t1, zero, 0 #contador do numero de insercoes feitas
	addi a2, zero, 1 #adiciona 2 no reg a2 p/ descolamento futuro
	slli a2, a2, 2	#multiplica para futuro deslocamento para insercao do endereco do proximo elemento
	addi a3, zero, 2
	slli a3, a3, 4
	addi a3, a3, -4 #faz somatoria que sera o numero de bytes a ser deslocado para o prox segmento de dados, onde sera armazenado o prox valor la lista
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
	sw a0, (s1)	#armazena o valor lido no registrador no endereco da lista
	add s1, s1, a2 #pula para proximo end da pilha
	add t2, s1, a3 #pula para o prox segmento de dados para insercao de novo valor
	sw t2, (s1)
	add s1, zero, t2
	j ordena_elementos

ordena_elementos:
	
	j lista_opcoes
	
remover_por_indice:
	j end
	
remover_por_valor:
	j end

listar_elementos:
	#nao funcional ainda
	la a0, msg_vet	#chama para imprimir vetor
	li a7, 4
	ecall
	lw t1, (s0)	#carrega valor da primeira posicao em t1
	add a0, t1, zero #o endereco do vetor esta em 
	li a7, 1
	ecall
	la a0, space
	li a7, 4
	ecall
	addi a4, a4, 1
	slli a4, a4, 2
	lw t0, (a4)
	sw s0, 4(a0)
end:
	nop
	ebreak
