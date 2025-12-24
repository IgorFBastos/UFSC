
const prompt = require('prompt-sync')();
const getClient = require('../config/dbClient');
const menuConsultTables = require('../interface/menuConsultTables');
const consultTable = require('../scripts/consultTable');
const tablesWrapper = require('../utils/tablesWrapper');



const tables_consult = {
    "1": "aluno",
    "2": "instrutor",
    "3": "plano",
    "4": "sala",
    "5": "modalidade",
    "6": "assinatura",
    "7": "pagamento",
    "8": "ficha_treino",
    "9": "exercicio",
    "10": "exe_ficha_treino",
    "11": "aula",
    "12": "inscricao_aula",
    "13": "avaliacao_fisica",
    "14": "tipo_medida",
    "15": "resultado_avaliacao",
    "16": "frequencia",
}




const handleConsultTables = async () => {

    menuConsultTables();

    const selectionTable = prompt("👉 Escolha uma opção: ");

    if (selectionTable === "0") return "back";

    const client = getClient();

    try {

        await client.connect();

        const tableName = tables_consult[selectionTable];
        const rows = await consultTable(client, tableName);

        tablesWrapper(rows);

        await client.end();

    } catch (error) {
        await client.end();

        if (error.code === "42P01") {
            console.log("\n❌ ERRO: Tabela não encontrada.");
            return;
        }

        throw error;
    }

}



module.exports = handleConsultTables;