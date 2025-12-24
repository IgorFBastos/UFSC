const menuConsultTables = require('../interface/menuConsultTables');
const prompt = require('prompt-sync')();
const getClient = require('../config/dbClient');
const consultTable = require('../scripts/consultTable');
const tablesWrapper = require('../utils/tablesWrapper');


const tabelasConfig = {
    "1": {tableName: "aluno", pkColumn: "matricula_aluno" },
    "2": {tableName: "instrutor", pkColumn: "cod_instrutor" },
    "3": {tableName: "plano", pkColumn: "cod_plano" },
    "4": {tableName: "sala", pkColumn: "cod_sala" },
    "5": {tableName: "modalidade", pkColumn: "cod_modalidade" },
    "6": {tableName: "assinatura", pkColumn: "cod_assinatura" },
    "7": {tableName: "pagamento", pkColumn: "cod_pagamento" },
    "8": {tableName: "ficha_treino", pkColumn: "cod_ficha_treino" },
    "9": {tableName: "exercicio", pkColumn: "cod_exercicio" },
    "10": {tableName: "exe_ficha_treino", pkColumn: "cod_exe_ficha_treino" },
    "11": {tableName: "aula", pkColumn: "cod_aula" },
    "12": {tableName: "inscricao_aula", pkColumn: null },
    "13": {tableName: "avaliacao_fisica", pkColumn: "cod_avaliacao_fisica" },
    "14": {tableName: "tipo_medida", pkColumn: "cod_tipo_medida" },
    "15": {tableName: "resultado_avaliacao", pkColumn: null }, 
    "16": {tableName: "frequencia", pkColumn: "cod_frequencia" },
};


const handleUpdateData = async () => {


    menuConsultTables();

    const selectionTable = prompt("👉 Escolha uma Tabela para Atualizar: ");

    if (selectionTable === "0") return "back";

    const client = getClient();


    try {

        await client.connect();

        const config = tabelasConfig[selectionTable];

        if (!config) {
            console.log("\n❌ Opção de tabela inválida.");
            return;
        }
        if (!config.pkColumn) {
            console.log(`\n❌ A atualização de dados na tabela '${config.tableName}' não é suportada por esta função devido à chave primária composta.`);
            return;
        }
        
        const rows = await consultTable(client, config.tableName);

        tablesWrapper(rows);

        if(rows.length === 0) return "back";

        console.log("");
        const selectionID = prompt(`👉 Digite o ID (${config.pkColumn}) da linha que deseja atualizar (ou 0 para voltar): `);

        if (selectionID === "0") return "back";

        const linhaResult = await client.query(`SELECT * FROM ${config.tableName} WHERE ${config.pkColumn} = $1`, [selectionID]);
        
        if (linhaResult.rows.length === 0) {
            console.log("\n❌ ID não encontrado. Operação cancelada.");
            return;
        }

        tablesWrapper(linhaResult.rows);

        const columnsUpdate = Object.keys(linhaResult.rows[0]).filter(col => col !== config.pkColumn);

        console.log("\nQual coluna você deseja alterar?\n");
        columnsUpdate.forEach((col, index) => {
            console.log(`  ${index + 1}. ${col}`);
        });
        console.log("  0. Voltar");

        console.log("");
        const selectionColumnIndex = prompt("👉 Escolha uma opção: ");

        if (selectionColumnIndex === "0") return "back";

        const columnToUpdate = columnsUpdate[parseInt(selectionColumnIndex) - 1];

        if (!columnToUpdate) {
            console.log("\n❌ Opção de coluna inválida.");
            return;
        }

        console.log("");
        const newValor = prompt(`👉 Digite o novo valor para a coluna '${columnToUpdate}': `);


        console.log("\n--- Revisão da Alteração ---\n");
        console.log(`   Tabela:   ${config.tableName}`);
        console.log(`   Registro: ${config.pkColumn} = ${selectionID}`);
        console.log(`   Coluna:   ${columnToUpdate}`);
        console.log(`   Valor Antigo: '${linhaResult.rows[0][columnToUpdate]}'`);
        console.log(`   Novo Valor:   '${newValor}'`);

        console.log("");
        const confirm = prompt("❓ Você confirma esta alteração? (s/n): ").toLowerCase();


        if (confirm === 's' || confirm === 'sim') {
            const updateQuery = `UPDATE ${config.tableName} SET "${columnToUpdate}" = $1 WHERE "${config.pkColumn}" = $2`;
            const result = await client.query(updateQuery, [newValor, selectionID]);

            if (result.rowCount > 0) {
                console.log("\n✅ Atualização realizada com sucesso!");

                const linhaResultUpdate = await client.query(`SELECT * FROM ${config.tableName} WHERE ${config.pkColumn} = $1`, [selectionID]);

                tablesWrapper(linhaResultUpdate.rows);

                const rows = await consultTable(client, config.tableName);

                tablesWrapper(rows);


            } else {
                console.log("\n⚠️ Nenhuma linha foi alterada. O registro pode ter sido removido.");
            }
        } else {
            console.log("\n❌ Operação cancelada pelo usuário.");
        }
    } catch (error) {
        throw error;
    } finally { 
        await client.end();
    }
}

module.exports = handleUpdateData;