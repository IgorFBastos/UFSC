const { Client } = require('pg');
require('dotenv').config();

const getClientDefault = () => {
    return new Client({
        user: process.env.PG_USER,
        host: process.env.PG_HOST,
        password: process.env.PG_PASSWORD,
        port: process.env.PG_PORT,
        database: process.env.PG_DATABASE_DEFAULT, 
    });
};

module.exports = getClientDefault;