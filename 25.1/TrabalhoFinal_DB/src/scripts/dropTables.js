



const dropTables = async (client, sql) => {

    try {

        await client.query(sql);

    } catch (error) {
        console.error("❌ ERRO: Erro deletar as tabelas.", error);
        throw error;
    }
}

module.exports = dropTables;      