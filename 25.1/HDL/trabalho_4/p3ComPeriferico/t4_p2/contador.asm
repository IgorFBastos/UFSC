.data
# Define "ponteiros" na memória que guardam os endereços dos periféricos de saída.
# Esta abordagem é sugerida na página 23 do PDF da apresentação.
out_dec_s: .word 0x10008000  # Endereço para DÉCIMOS de segundo [cite: 795, 796]
out_un:    .word 0x10008001  # Endereço para UNIDADES de segundo [cite: 797, 799]
out_dz:    .word 0x10008002  # Endereço para DEZENAS de segundo [cite: 800, 801]
out_ct:    .word 0x10008003  # Endereço para CENTENAS de segundo [cite: 802, 803]

.text
.globl main

main:
    # Passo 1 do Enunciado: Zerar os quatro registradores que armazenarão os dígitos. 
    li $s3, 0   # s3 = Centenas
    li $s2, 0   # s2 = Dezenas
    li $s1, 0   # s1 = Unidades
    li $s0, 0   # s0 = Décimos

    # Pula para o loop principal para iniciar a execução do cronômetro.
    j main_loop

main_loop:
    # Passo 2 do Enunciado (Parte A): Escrever os 4 valores na saída. [cite: 785]
    # O código abaixo usa a dica da página 23 do PDF para escrever em memória. 
    
    # Escreve o dígito dos DÉCIMOS ($s0) no endereço correspondente.
    la $t0, out_dec_s   # Carrega o endereço do ponteiro 'out_dec_s' para $t0.
    lw $t0, 0($t0)      # Carrega o valor do ponteiro (0x10008000) para $t0.
    sb $s0, 0($t0)      # Armazena o byte do registrador $s0 no endereço de saída.

    # Escreve o dígito das UNIDADES ($s1).
    la $t0, out_un
    lw $t0, 0($t0)
    sb $s1, 0($t0)

    # Escreve o dígito das DEZENAS ($s2).
    la $t0, out_dz
    lw $t0, 0($t0)
    sb $s2, 0($t0)

    # Escreve o dígito das CENTENAS ($s3).
    la $t0, out_ct
    lw $t0, 0($t0)
    sb $s3, 0($t0)
    
    # Passo 2 do Enunciado (Parte B): Verificar condição de parada em 999.9s. 
    li $t1, 9                       # Carrega 9 em um temporário para comparação.
    bne $s0, $t1, continue_counting # Se décimos != 9, continua a contar.
    bne $s1, $t1, continue_counting # Se unidades != 9, continua a contar.
    bne $s2, $t1, continue_counting # Se dezenas != 9, continua a contar.
    bne $s3, $t1, continue_counting # Se centenas != 9, continua a contar.
    j halt                          # Se todos forem 9, o programa para.

continue_counting:
    # Passo 3 do Enunciado: Chamar uma função que espera. [cite: 787]
    jal delay_real

    # Passo 4 do Enunciado: Incrementar a contagem. [cite: 788]
    addi $s0, $s0, 1                # 1. Incrementa o DÉCIMO de segundo.
    li $t1, 10                      # Carrega 10 para verificar o estouro (carry).
    bne $s0, $t1, end_increment     # Se $s0 < 10, o incremento deste ciclo terminou.

    li $s0, 0                       # 2. Se $s0 chegou a 10, zera o DÉCIMO...
    addi $s1, $s1, 1                #    ...e incrementa a UNIDADE.
    bne $s1, $t1, end_increment     # Se $s1 < 10, terminou.

    li $s1, 0                       # 3. Se $s1 chegou a 10, zera a UNIDADE...
    addi $s2, $s2, 1                #    ...e incrementa a DEZENA.
    bne $s2, $t1, end_increment     # Se $s2 < 10, terminou.

    # -- CORREÇÃO DO BUG ESTÁ AQUI --
    li $s2, 0                       # 4. Se $s2 chegou a 10, zera a DEZENA...
    addi $s3, $s3, 1                #    ...e incrementa a CENTENA.

end_increment:
    # Volta ao início do loop para repetir todo o processo.
    j main_loop

halt:
    # Loop infinito para "travar" o processador quando a contagem termina.
    j halt

#----------------------------------------------------
# Sub-rotina de Atraso
#----------------------------------------------------
delay_real:
    # Usando um valor pequeno para que a simulação seja rápida,
    # como sugerido na página 23 do PDF. Valor real para contagem = 2499985
    li $t5, 1000000
delay_real_loop:
    addi $t5, $t5, -1               # Decrementa o contador do loop.
    bne $t5, $zero, delay_real_loop # Se o contador não é zero, repete o loop.
    jr $ra                          # Retorna para quem chamou a função.
