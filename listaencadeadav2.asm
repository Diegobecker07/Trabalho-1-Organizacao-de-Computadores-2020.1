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
msg_erro_listagem: .string "Lista est� vazia!"
msg_digite_indice: .string "Digite o indice o qual deseja remover"
msg_indice_maior: .string "O numero e maior do que o numero de indices inseridos no vetor!"
msg_nao_encontrou: .string "O valor nao consta no vetor!"
msg_digite_valor: .string "Digite o valor o qual deseja remover"
vlr_prim_rem:	.string "Primeiro valor removido com exito!"
vlr_ult_rem:	.string "Ultimo valor removido com exito!"
lst_vazia:	.string "Lista vazia!"

	.text
main:
	addi sp, sp, -8
	add s0, zero, sp #carrega endere�o inicial do vetor alocado
	add s1, zero, sp #carrega endere�o inicial do vetor alocado p/ futuras insercoes
	add s2, zero, sp #carrega endere�o inicial do vetor alocado p/ futuras ordenacoes
	add s3, zero, s0 #carrega endere�o inicial do vetor alocado p/ futuras remocoes
	add t1, zero, zero #contador do numero de insercoes feitas
	addi t2, zero, 4 #add 4 p/ deslocamento futuro
	add s10, zero, zero #futuramente usado para remover elemento
	add a4, zero, zero
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
	li a7, 4		#ele d� erro e manda inserir novamente
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
	sw sp, (s1) #armazena o endere�o do segundo elemento no n� do anterior
	add s1, sp, t2	#carrega o endereco que vai o prox endereco do valor da lista
	addi t1, t1, 1
	j lista_opcoes
	#j ordena_elementos

#fun��o que faz a inser��o dos dados na lista
insere_primeiro:
	sw a0, (sp)
	sw zero, 4(sp)
	addi t1, zero, 1
	add s1, sp, t2 #carrega o endereco que vai o prox endereco do valor da lista
	j lista_opcoes
	
#func�o que ordena os elementos adicionados
#nao funcional ainda
ordena_elementos:
	#add t5, s2, t2
	#lw t5, (t5)
	#beq t5, zero, lista_opcoes 
	lw s5, (s2) #carrega o valor de s2(que no inicio � o primeiro end do vetor) 
	lw s7, 4(s2) #carrega endere�o do prox elemento em s7
	beq s7, zero, init
	lw s6, (s7)
	add s8, zero, ra #guarda valor pra retorno
	blt s6, s5, swap_vetor
	
swap_vetor:
	sw s6, (s2)
	sw s5, (s7)
	add s2, zero, s7
	j ordena_elementos 
	
init:
	add s2, zero, s0 #coloca o primeiro endereco novamente no s2 para futura ordenacao
	j lista_opcoes

#fun��o que faz a remo��o do valor passado
remover_por_valor:
	beq, t1, zero, lista_vazia
	la a0, msg_digite_valor
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	jal for
	
lista_vazia:
	la a0, lst_vazia
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
for:
	lw s5, (s3) #armazena o valor que esta no end s3 no reg s5
	lw s3, 4(s3) #armazena o end do proximo elemento pra verificar novamente
	beq s3, zero, ultimo_valor
	beq s5, a0, encontrou_valor_remocao
	addi s10, s10, 1
	add s4, zero, s3
	j for

ultimo_valor:
	beq s5, a0, encontrou_valor_remocao_ultimo
	j nao_encontrou
			
encontrou_valor_remocao:
	add s11, zero, zero
	beq s10, s11, remover_primeiro_elem
	
encontrou_valor_remocao_ultimo:
	sw a4, (s4)	
	la a0, vlr_ult_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	add s3, zero, s0
	j lista_opcoes
	
remover_primeiro_elem: #atualiza o endereco inicial do vetor pro segundo
	lw s9, 4(s0)
	add s0, zero, s9
	add s1, zero, s9
	add s2, zero, s9
	add s3, zero, s9
	la a0, vlr_prim_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
	
nao_encontrou:
	la a0, msg_nao_encontrou
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	add s10, zero, zero
	j lista_opcoes
	
valor_acima:
	la a0, msg_indice_maior
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	add s10, zero, zero
	j lista_opcoes
	
#funcao que faz a remocao pelo indice da lista passado	
remover_por_indice:
	j end

#come�a funcao para imprimir o vetor
listar_elementos:
	add s3, zero, s0
	beq t1, zero, errodelistagem
	la a0, msg_vet
	li a7, 4
	ecall
	j lista
	
lista:
	lw a0, (s3)
	li a7, 1
	ecall
	lw s3, 4(s3)
	beq s3, zero, fimlistagem
	la a0, space
	li a7, 4
	ecall
	j lista
	
fimlistagem:
	add s3, zero, s0 #retorna s0 para o endereco inicial da lista
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
	
	
errodelistagem: #se a lista estiver vazia, ele da mensagem de erro e retorna para o menu
	la a0, msg_erro_listagem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes
	
#funcao para finalizar o programa	
end:
	nop
	ebreak
