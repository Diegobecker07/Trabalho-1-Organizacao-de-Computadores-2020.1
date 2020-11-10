#Diego Luiz Becker
#Luandro Inseschi
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
space:		.string " "
msg_valor_erro: .string "Valor digitado invalido insiva novamente um valor valido"
msg_qual_valor: .string "Digite o valor a ser inserido na lista"
msg_erro_inser: .string "Nao foi possivel inserir o valor na lista"

	.text
main:
	addi sp, sp, -8
	add s0, zero, sp #carrega endereço inicial do vetor alocado
	add s1, zero, sp #carrega endereço inicial do vetor alocado p/ futuras insercoes
	add t1, zero, zero #contador do numero de insercoes feitas
	addi t2, zero, 4 #add 4 p/ deslocamento futuro
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
	j lista_opcoes
	
insere_elemento:
	la a0, msg_qual_valor
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	beq t1, zero, insere_primeiro
	addi sp, sp, -8
	sw a0, (sp)
	sw zero, 4(sp)
	sw sp, (s1) #armazena o endereço do segundo elemento no nó do anterior
	add s1, sp, t2	#carrega o endereco que vai o prox endereco do valor da lista
	addi t1, zero, 1
	j lista_opcoes
	
insere_primeiro:
	sw a0, (sp)
	sw zero, 4(sp)
	addi t1, zero, 1
	add s1, sp, t2 #carrega o endereco que vai o prox endereco do valor da lista
	j lista_opcoes
	
ordena_elementos:
	
	j lista_opcoes
	
remover_por_indice:
	j end
	
remover_por_valor:
	j end

listar_elementos:
	j end
end:
	nop
	ebreak