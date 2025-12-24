
const getClient = require('../config/dbClient');
const createTables = require('../scripts/createTables');
const delay = require('../utils/delay');
const fs = require('fs');


const handleCreateTables = async () => {

    const client = getClient();

    try {

        console.log("\n⚙️ CRIANDO TABELAS \n");
        await delay(500);

        console.log("➡️ Passo 1: Conectando ao PostgreSQL...");
        await delay(500);
        await client.connect();
        console.log("✅ Conectado ao banco com sucesso!");
        await delay(500);

        console.log("➡️ Passo 2: Lendo script SQL para criação das tabelas...");
        await delay(500);
        const sql = fs.readFileSync('./src/sql/01_createTables.sql', 'utf8');
        console.log("✅ Script lido com sucesso!");
        await delay(500);

        console.log("➡️ Passo 3: Criando as tabelas...");
        await delay(500);
        await createTables(client, sql);
        console.log("✅ Tabelas criadas com sucesso!");
        await delay(500);

        console.log("➡️ Passo 4: Desconectando do PostgreSQL...");
        await client.end();
        await delay(500);
        console.log("✅ Desconectado do banco com sucesso!");
        await delay(500);

    } catch (error) {

        if (error.code === "42P07") {
            console.log("❌ As tabelas já foram criadas no sistema.");
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


module.exports = handleCreateTables;