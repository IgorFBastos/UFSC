const createDatabase = require('../scripts/createDatabase');
const checkDatabaseExists = require('../scripts/checkDatabaseExists');
const delay = require('../utils/delay');
const prompt = require('prompt-sync')();


const configSystem = async () => {

    try {
        console.log("🛠️ CONFIGURANDO SISTEMA \n");
        await delay(500);

        console.log("⚙️ Verificando se o banco para o sistema já existe...");
        await delay(500);
        const database = await checkDatabaseExists();

        if (database) {
            console.log("✅ Banco já existe!");
            await delay(500);

            console.log("⚙️ Iniciando sistema...");
            await delay(500);
            return;
        }

        console.log("❌ Banco de dados não existe.");
        await delay(500);

        console.log("⚙️ Criando o banco para o sistema...");
        await delay(500);
        await createDatabase();
        console.log("✅ Banco criado com sucesso!");
        await delay(500);

        console.log("⚙️ Preparando Sistema...");
        await delay(500);


    } catch (error) {
        throw error;
    }
}


module.exports = configSystem;