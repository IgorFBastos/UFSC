

# 1. Usar uma imagem oficial do Node.js (versão 20)
FROM node:20

# 2. Criar diretório de trabalho dentro do container
WORKDIR /Diagnosoft_API

# 3. Copiar os arquivos de dependência (package.json e package-lock.json)
COPY package*.json ./

# 4. Instalar as dependências do projeto
RUN npm install

# 5. Copiar todo o restante do código para dentro do container
COPY . .

# 6. Expor a porta que a API vai usar 
EXPOSE 5000

# 7. Comando padrão para rodar a API
CMD ["node", "server.js"]
