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
msg_erro_listagem: .string "Lista está vazia!"
msg_indice_maior: .string "O numero e maior do que o numero de indices inseridos no vetor!"
msg_nao_encontrou: .string "O valor nao consta no vetor!"
msg_digite_valor: .string "Digite o valor o qual deseja remover"
vlr_prim_rem:	.string "Primeiro valor removido com exito!"
vlr_ult_rem:	.string "Ultimo valor removido com exito!"
lst_vazia:	.string "Lista vazia!"
msg_digite_indice: .string "Digite qual índice voce deseja remover"
msg_2_indice: .string "Segundo indice removido com sucesso!"

	.text
main:
	addi sp, sp, -8
	add s0, zero, sp #carrega endereço inicial do vetor alocado
	add s1, zero, sp #carrega endereço inicial do vetor alocado p/ futuras insercoes
	add s2, zero, sp #carrega endereço inicial do vetor alocado p/ futuras ordenacoes
	add s3, zero, s0 #carrega endereço inicial do vetor alocado p/ futuras remocoes
	add t1, zero, zero #contador do numero de insercoes feitas
	addi t2, zero, 4 #add 4 p/ deslocamento futuro
	addi s10, zero, 1 #futuramente usado para remover elemento
	add a4, zero, zero
	j lista_opcoes
################################################################################################## OK

 #faz chamada para listar todos os elementos que podem ser chamados
lista_opcoes:
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
############################################################################################################
#função para inserir um elemento na lista
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
	addi sp, sp, -8 #armazena 8 bytes sendo 4 para o inteiro e 4 para o próx endereço
	sw a0, (sp)
	sw zero, 4(sp)
	sw sp, (s1) #armazena o endereço do segundo elemento no nó do anterior
	add s1, sp, t2	#carrega o endereco que vai o prox endereco do valor da lista
	addi t1, t1, 1 #incrementa o valor de quantos tem na lista
	j lista_opcoes
	#j ordena_elementos

#função que faz a inserção do primeiro valor na lista
insere_primeiro:
	sw a0, (sp)
	sw zero, 4(sp)
	addi t1, zero, 1
	add s1, sp, t2 #carrega o endereco que vai o prox endereco do valor da lista
	j lista_opcoes
######################################################################################################## Ok

#funcão que ordena os elementos adicionados
#nao funcional ainda
ordena_elementos:
	#add t5, s2, t2
	#lw t5, (t5)
	#beq t5, zero, lista_opcoes 
	lw s5, (s2) #carrega o valor de s2(que no inicio é o primeiro end do vetor) 
	lw s7, 4(s2) #carrega endereço do prox elemento em s7
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
################################################################################################## <VERIFICAR>

#função que faz a remoção na lista do valor passado, se existir
remover_por_valor: #solicita o valor que deseja ser removido, caso a lista não esteja vazia
	beq, t1, zero, lista_vazia #se t1 é zero, desvia pro erro de lista vazia
	la a0, msg_digite_valor	#pede valor no teclado
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	jal for #desvia pro loop
	
lista_vazia: #retorna mensagem dizendo q a lista esta vazia para remover algum elemento
	la a0, lst_vazia
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	j lista_opcoes
	
for: #loop para percorrer a lista e procurar o elemento a ser removido
	lw s5, (s3) #armazena o valor que esta no end s3 no reg s5
	beq s10, t1, ultimo_valor #verifica se e o ultimo valor do for
	beq s5, a0, encontrou_valor_remocao #verifica se o valor foi encontrado
	lw s3, 4(s3) #armazena o end do proximo elemento pra verificar novamente
	addi s10, s10, 1
	j for

ultimo_valor: #quando chega no ultimo valor e n encontrou, faço uma chamada especial para ver se o ultimo é o valor procurado, ou se nenhum valor digitado possui na lista
	beq s5, a0, encontrou_valor_remocao_ultimo
	j nao_encontrou
			
encontrou_valor_remocao:
	addi s11, zero, 1
	beq s10, s11, remover_primeiro_elem #desvia para funcao que remove primeiro indice

	
encontrou_valor_remocao_ultimo:
	sw a4, (s4)	
	la a0, vlr_ult_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	j lista_opcoes
	
remover_primeiro_elem: #atualiza o endereco inicial do vetor pro segundo, teoricamente removendo o primeiro elemento
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
	jal limpa_reg
	j lista_opcoes
	
nao_encontrou: #retorna a mensagem que o valor inserido nao está na lista
	la a0, msg_nao_encontrou
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal limpa_reg
	j lista_opcoes

limpa_reg:
	addi s10, zero, 1
	add s5, zero, zero
	add s3, zero, s0
	add s11, zero, zero
	ret
################################################################################################<VERIFICAR>
	
#funcao que faz a remocao pelo indice da lista informado pelo usuário	
remover_por_indice:
	la a0, msg_digite_indice
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	li a7, 5 #le valor digitado no teclado e armazena em a0
	ecall
	addi s9, zero, 1
	bge a0, t1, valor_acima #se o valor digitado é maior do que o índice, ele desvia avisando o erro e volta para o menu
	beq a0, s9, remove_prim
	j insere_posicoes

insere_posicoes:
	addi s9, s9, 1
	addi s4, s3, 4 #pega o end de mem do segundo valor
	lw s5, 4(s3) #pega pega o end de mem do segundo valor
	lw s8, (s5) #le o valor que vao ser verificado
	lw s7, 4(s5)
	beq a0, s9, swap1
swap1:
	sw s7, (s4)
	la a0, msg_2_indice
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal lmp_reg
	j lista_opcoes
	
remove_prim:
	lw s5, 4(s3)
	add s0, zero, s5
	add s1, zero, s5
	add s2, zero, s5
	add s3, zero, s5
	la a0, vlr_prim_rem
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	jal lmp_reg
	j lista_opcoes
	
valor_acima:
	la a0, msg_indice_maior
	li a7, 4
	ecall
	la a0, quebra_linha
	li a7, 4
	ecall
	j lista_opcoes

lmp_reg:
	add s5, zero, zero
	add s6, zero, zero
	add s7, zero, zero
	add s8, zero, zero
	add s9, zero, zero
	add t3, zero, zero
	ret
	
############################################################################################# OK
#começa funcao para imprimir o vetor
listar_elementos:
	add s3, zero, s0
	beq t1, zero, errodelistagem
	la a0, msg_vet
	li a7, 4
	ecall
	j lista
	
lista:	#Faz um loop para impressao 
	lw a0, (s3)
	li a7, 1
	ecall
	lw s3, 4(s3)
	beq s3, zero, fimlistagem
	la a0, space
	li a7, 4
	ecall
	j lista
	
fimlistagem: #quebra linha e volta para o menu após terminar de listar os elementos
	add s3, zero, s0 #retorna s3 para o endereco inicial da lista
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
	
################################################################################################# OK
#funcao para finalizar o programa	
end:
	nop
	ebreak
