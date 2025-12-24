
const getClientDefault = require('../config/dbClientDefault');
require('dotenv').config();

const DB_NAME = process.env.PG_DATABASE;

const checkDatabaseExists = async () => {

    const client = getClientDefault();

    await client.connect();

    try {
        
        const checkDB = await client.query(
            "SELECT 1 FROM pg_database WHERE datname = $1",
            [DB_NAME]
        );

        if (checkDB.rowCount > 0) {
            return true;
        } else {
            return false;
        }

    } catch (error) {
        console.error("❌ ERRO: Erro ao verificar banco.", error);
        throw error;

    } finally {
        client.end();
    }
}


module.exports = checkDatabaseExists; 