

const createTables = async (client, sql) => {

    try {
        await client.query(sql);

    } catch (error) {
        if(error.code === "42P07") throw error;

        console.error("❌ ERRO: Erro ao criar as tabelas.", error);
        throw error;
    }
}

module.exports = createTables;      