#include <stdio.h>
#include <string.h>
#include "BD.h"


typedef struct {
    char nome[20];
    int codigo;
}REG;





int comp_cod ( void * A, void * B)
{
    REG *ptr;
    int * ptr2;
    ptr = (REG *) A;
    ptr2 = (int * )B;
    if (ptr->codigo == *ptr2) return 0;
    return 1;
}

int comp_nome ( void * A, void * B)
{
    REG *ptr;
    char * ptr2;
    ptr = (REG *) A;
    ptr2 = (char * )B;
    if (strcmp(ptr->nome, ptr2)==0) return 0;
    return 1;
}

void mostraTela (REG b)
{
   printf("Nome=%s\n",b.nome);
    printf("Codigo=%d\n",b.codigo);

}

void insereDados(void)
{
    REG dados;

    strcpy(dados.nome,"Luis Felipe");
    dados.codigo = 456;
    BD_novoRegistro((void *) &dados);

    strcpy(dados.nome,"Maria Antonia");
    dados.codigo = 123;
    BD_novoRegistro((void *) &dados);

    strcpy(dados.nome,"Pedro terra");
    dados.codigo = 434;
    BD_novoRegistro((void *) &dados);

    strcpy(dados.nome,"Ana terra");
    dados.codigo = 556;
    BD_novoRegistro((void *) &dados);

    strcpy(dados.nome,"Wolverine");
    dados.codigo = 789;
    BD_novoRegistro((void *) &dados);

}
int main (void)
{
    char busca[20];

    strcpy (busca, "Pedro terra");



    tipo_configuracao conf;
    strcpy(conf.nomeBD,"DADOS.DAD");
    conf.tamanhoRegistros = sizeof(REG);

    BD_init (conf);

    insereDados();


    BD_pesquisa (comp_nome, (void *) busca);

    REG S;

    BD_mostra ((void *) &S, 3);
    mostraTela(S);

}
