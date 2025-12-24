require('dotenv').config();
const getClientDefault = require('../config/dbClientDefault');

const DB_NAME = process.env.PG_DATABASE

const createDatabase = async () => {

    const client = getClientDefault();

    await client.connect();

    try {
        await client.query(`CREATE DATABASE ${DB_NAME}`);

    } catch (error) {
        console.error("❌ ERRO: Erro ao criar banco.", error);
        throw error;
    } finally {
        await client.end();
    }
}


module.exports = createDatabase;