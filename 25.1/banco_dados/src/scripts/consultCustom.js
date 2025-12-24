

const consultTable = async (client, sql) => {

    try {

        const consult = await client.query(sql);

        return consult.rows;

    } catch (error) {
        if(error.code === "42P01") throw error;
        console.error(`❌ ERRO: Não foi possivel realizar a consulta.".`, error);
        throw error;
    }
}

module.exports = consultTable;      