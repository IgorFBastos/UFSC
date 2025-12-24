

# 🤖 Sistema de Gerenciamento de Academia com IA

Este é um projeto de um sistema de gerenciamento para academias, desenvolvido em Node.js. O sistema permite controlar alunos, planos, pagamentos, treinos e integra uma IA para fornecer insights de negócio.

## ✨ Funcionalidades

- Criação e gerenciamento de tabelas do banco de dados.
- Inserção e consulta de dados (alunos, instrutores, planos, etc.).
- Geração de gráficos para visualização de dados (ex: receita por plano).
- Módulo de atualização interativo para registros do banco.
- Integração com a API da OpenAI (`gpt-4o-mini`) para gerar análises e sugestões estratégicas.

## 🚀 Tecnologias Utilizadas

- **Backend:** Node.js
- **Banco de Dados:** PostgreSQL
- **IA Generativa:** API da OpenAI
- **Interface de Console:** `prompt-sync`, `cli-table3`
- **Visualização de Dados:** `quickchart-js`
- **Ambiente:** `dotenv`

## ⚙️ Como Executar o Projeto

Siga os passos abaixo para configurar e rodar o projeto em seu ambiente local.

**1. Clone o Repositório**
```bash
https://github.com/IgorFBastos/TrabalhoFinal_DB.git
cd TrabalhoFinal_DB
```

**2. Instale as Dependências**
```bash
npm install
```

**3. Configure as Variáveis de Ambientes**

- Crie um arquivo chamado .env na raiz do projeto.
- Adicione as seguintes variáveis e preencha com suas credenciais:

```bash
DB_HOST=localhost
DB_USER=seu_usuario_postgres
DB_PASSWORD=sua_senha
DB_NAME=academia
DB_PORT=5432
OPENAI_API_KEY=sk-sua-chave-secreta
```

**4. Prepare o Banco de Dados**

- Garanta que seu servidor PostgreSQL esteja em execução.

**5. Execute a Aplicação**
```bash
npm run start
```



