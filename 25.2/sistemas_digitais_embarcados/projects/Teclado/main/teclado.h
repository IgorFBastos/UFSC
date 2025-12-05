#ifndef __TECLADO__
#define __TECLADO__

// Linhas (saída)
#define R1 15
#define R2 12
#define R3 2
#define R4 13

// Colunas (entrada)
#define C1 27
#define C2 26
#define C3 25
#define C4 14

#define ROWS 4
#define COLS 4

#define HIGH 1
#define LOW 0

// Funções
void init_teclado(void);
char leiaTecla(void);

#endif