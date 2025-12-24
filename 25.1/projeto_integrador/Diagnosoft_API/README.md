# 🩺 Diagnosoft

**Diagnosoft** é uma plataforma voltada para profissionais da saúde que desejam criar formulários de triagem personalizados para seus pacientes. Através do sistema, é possível cadastrar diferentes tipos de perguntas — objetivas, discursivas e matemáticas — permitindo uma análise mais precisa e automatizada de dados clínicos.

## ✨ Funcionalidades

- Cadastro de profissionais da saúde.
- Criação de formulários personalizados com:
    - **Perguntas objetivas** (de assinalar).
    - **Perguntas discursivas** (respostas por escrito).
    - **Perguntas matemáticas**, onde é possível definir **fórmulas personalizadas** que processam os dados inseridos com o auxílio da biblioteca [Math.js](https://mathjs.org/).
- Avaliação automatizada de respostas numéricas com base em fórmulas clínicas.
- API RESTful pronta para integração com frontend ou aplicativos móveis.
- Exportação dos dados com as devidas conclusões

---

## 🚀 Como rodar a API com Docker

Para executar o projeto localmente usando Docker, siga os passos abaixo:

### Pré-requisitos

- Docker instalado: https://docs.docker.com/get-docker/

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/diagnosoft.git
cd diagnosoft
```

### 2. Configure as variáveis de ambiente

Na raiz do projeto, crie um arquivo `.env` (não versionar, adicione ao `.gitignore`) com as seguintes chaves:

```bash
# Porta que sua API vai escutar
PORT=5000

# Credenciais e cluster do MongoDB Atlas
DB_USER=<seu_usuario_atlas>
DB_PASSWORD=<sua_senha_atlas>
DB_CLUSTER=<seu_cluster>.mongodb.net
DB_NAME=<nome_do_banco>      # será criado automaticamente na primeira escrita
```

### 3. Se quiser validar localmente antes de containerizar:

```bash
npm install
```

### 4. Suba os containers com Docker Compose

```bash
docker-compose up --build
```

### 5. Suba a API

```bash
docker-compose up
```

A aplicação será iniciada e poderá ser acessada em:

```bash
http://localhost:5000
```

Ou outra porta definida no `.env`.

- O serviço **api** usará o `Dockerfile` para criar a imagem.
- A porta **5000** do container ficará disponível em `http://localhost:5000`.
- O **nodemon** executará `npm run dev` e recarregará automaticamente a cada alteração de código.
- As variáveis do seu `.env` serão carregadas pelo `docker-compose.yml`.

---

## 🧮 Como funciona a biblioteca Math.js no Diagnosoft

A biblioteca [Math.js](https://mathjs.org/) é utilizada para interpretar e calcular expressões matemáticas fornecidas pelo profissional da saúde nas perguntas do tipo "matemática".

### ✅ Exemplo de uso:

Suponha que um profissional deseje calcular o **IMC (Índice de Massa Corporal)** de um paciente. Ele pode cadastrar a seguinte fórmula:

```jsx
peso / (altura ^ 2)
```

Na aplicação, ao responder a pergunta, o paciente (ou o profissional, preenchendo os dados) insere os valores de `peso` e `altura`. O sistema substitui esses valores na fórmula e realiza o cálculo automaticamente.

### ⚙️ Internamente, o processo segue estes passos:

1. O profissional cadastra a pergunta e fornece uma fórmula como string:
    
    ```jsx
    "peso / (altura ^ 2)"
    ```
    
2. O sistema usa o `math.evaluate()` para interpretar e resolver:
    
    ```jsx
    const math = require('mathjs');
    
    // uso por atribuição
    const formula = "peso / (altura ^ 2)";
    const resultado = math.evaluate(formula, { peso: 70, altura: 1.75 });
    console.log(resultado);
    
    // uso por expressão direta
    const expressao = "(5 + ((2 * sqrt(7)) ^ 2)) / 5 ^ 2";
    const resultado = math.evaluate(expressao);
    console.log(resultado);
    
    // uso por expressão direta + variáveis
    var a = 4;
    var b = 7;
    var c = 2;
    const expressao = `(5 + ((${a} * sqrt(${b})) ^ 2)) / ${c} ^ 2`;
    const resultado = math.evaluate(expressao);
    console.log(resultado);
    ```
    
3. O resultado pode ser armazenado e/ou exibido como parte da avaliação do paciente.

### ✅ Recursos suportados:

- Operações aritméticas: `+`, , , `/`, `^`
- Funções matemáticas: `sqrt()`, `log()`, `abs()`, `min()`, `max()`, etc.
- Variáveis dinâmicas: `idade`, `frequencia`, `pressao`, etc., definidas por quem cria a pergunta

---

## 🛠 Tecnologias utilizadas

- **Node.js / Express** – Backend da aplicação
- **Math.js** – Avaliação de expressões matemáticas
- **Docker / Docker Compose** – Contêineres e ambiente isolado
- **Mongo  / Atlas -** Banco de dados

---

## 🙌 Contribuindo

Contribuições são bem-vindas! Para isso:

1. Faça um fork do projeto.
2. Crie uma branch para sua feature ou correção: `git checkout -b minha-feature`
3. Faça commit das suas alterações: `git commit -m 'Adiciona nova feature'`
4. Faça push para sua branch: `git push origin minha-feature`
5. Abra um Pull Request 🚀

---
