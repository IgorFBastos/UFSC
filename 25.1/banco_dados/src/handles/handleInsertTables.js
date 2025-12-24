
const getClient = require('../config/dbClient');
const insertTables = require('../scripts/insertTables');
const delay = require('../utils/delay');
const fs = require('fs');



const handleInsertTables = async () => {

    const client = getClient();

    try {
        console.log("\n⚙️ INSERINDO DADOS \n");
        await delay(500);

        console.log("➡️ Passo 1: Conectando ao PostgreSQL...");
        await delay(500);
        await client.connect();
        console.log("✅ Conectado ao banco com sucesso!");
        await delay(500);

        console.log("➡️ Passo 2: Lendo script SQL para criação das tabelas...");
        await delay(500);
        const sql = fs.readFileSync('./src/sql/03_insertTables.sql', 'utf8');
        console.log("✅ Script lido com sucesso!");
        await delay(500);

        console.log("➡️ Passo 3: Inserindo dados nas tabelas...");
        await delay(500);
        await insertTables(client, sql);
        console.log("✅ Dados inseridos com sucesso!");
        await delay(500);

        console.log("➡️ Passo 4: Desconectando do PostgreSQL...");
        await client.end();
        await delay(500);
        console.log("✅ Desconectado do banco com sucesso!");
        await delay(500);

    } catch (error) {

        if(error.code === "42P01") {
            console.log(`❌ ERRO: Tabelas não encontradas. Você precisa criá-las antes de inserir dados.`);
            await delay(500);

            console.log("➡️ Passo 4: Desconectando do PostgreSQL...");
            await client.end();
            await delay(500);
            console.log("✅ Desconectado do banco com sucesso!");
            await delay(500);
            return;
        }

        if (error.code === "23505") {
            console.log(`❌ ERRO: ${error.detail}`);
            await delay(500);

            console.log("➡️ Passo 4: Desconectando do PostgreSQL...");
            await client.end();
            await delay(500);
            console.log("✅ Desconectado do banco com sucesso!");
            await delay(500);
            return;
        }

        await client.end();
        throw error;
    }
}




module.exports = handleInsertTables;