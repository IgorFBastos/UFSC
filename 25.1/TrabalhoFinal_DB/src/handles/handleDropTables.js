
const getClient = require('../config/dbClient');
const dropTables = require('../scripts/dropTables');
const delay = require('../utils/delay');
const fs = require('fs');

const handleDropTables = async () => {

    const client = getClient();

    try {

        console.log("\n⚙️ EXCLUINDO TABELAS \n");
        await delay(500);

        console.log("➡️ Passo 1: Conectando ao PostgreSQL...");
        await delay(500);
        await client.connect();
        console.log("✅ Conectado ao banco com sucesso!");
        await delay(500);

        console.log("➡️ Passo 2: Lendo script SQL para criação das tabelas...");
        await delay(500);
        const sql = fs.readFileSync('./src/sql/02_dropTables.sql', 'utf8');
        console.log("✅ Script lido com sucesso!");
        await delay(500);

        console.log("➡️ Passo 3: Excluindo as tabelas...");
        await delay(500);
        await dropTables(client, sql);
        console.log("✅ Tabelas excluidas com sucesso!");
        await delay(500);

        console.log("➡️ Passo 4: Desconectando do PostgreSQL...");
        await client.end();
        await delay(500);
        console.log("✅ Desconectado do banco com sucesso!");
        await delay(500);

    } catch (error) {
        await client.end();
        throw error;
    }
}


module.exports = handleDropTables;