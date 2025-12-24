-- Passo 1: Remover as tabelas que possuem as dependências mais fortes (as que mais apontam para outras).
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS inscricao_aula;
DROP TABLE IF EXISTS resultado_avaliacao;
DROP TABLE IF EXISTS exe_ficha_treino;
DROP TABLE IF EXISTS frequencia;


-- Passo 2: Remover as tabelas "intermediárias" que eram referenciadas no Passo 1.
DROP TABLE IF EXISTS assinatura;
DROP TABLE IF EXISTS aula;
DROP TABLE IF EXISTS avaliacao_fisica;
DROP TABLE IF EXISTS ficha_treino;


-- Passo 3: Remover as tabelas "base" ou "catálogo", que não dependem de mais ninguém.
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS instrutor;
DROP TABLE IF EXISTS plano;
DROP TABLE IF EXISTS sala;
DROP TABLE IF EXISTS modalidade;
DROP TABLE IF EXISTS exercicio;
DROP TABLE IF EXISTS tipo_medida;
