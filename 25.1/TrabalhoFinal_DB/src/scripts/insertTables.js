



const insertTables = async (client, sql) => {

    try {

        await client.query(sql);

    } catch (error) {
        if (error.code === "23505") throw error;
        if (error.code === "42P01") throw error;
        
        console.error("❌ ERRO: Erro inserir dados nas tabelas.", error);
        throw error;
    }
}

module.exports = insertTables;      