





const consultTable = async (client, table) => {

    try {

        const consult = await client.query(`SELECT * FROM ${table}`);

        return consult.rows;

    } catch (error) {
        if(error.code === "42P01") throw error;
        console.error(`❌ ERRO: Erro ao consultar tabela "${table}".`, error);
        throw error;
    }
}

module.exports = consultTable;      