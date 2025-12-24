const prompt = require('prompt-sync')();
const getClient = require('../config/dbClient');
const menuConsultCustom = require('../interface/menuConsultCustom');
const consultCustom = require('../scripts/consultCustom');
const chartConsult_1 = require('../utils/chartConsult_1');
const chartConsult_2 = require('../utils/chartConsult_2');
const chartConsult_3 = require('../utils/chartConsult_3');
const tablesWrapper = require('../utils/tablesWrapper');
const fs = require('fs');


const handleConsultCustom = async () => {

    menuConsultCustom();

    const consult_option = prompt("👉 Escolha uma opção: ");

    if (consult_option === "0") return "back";

    const client = getClient();


    
    try {

        await client.connect();

        if(consult_option === "1") {
            const sql = fs.readFileSync('./src/sql/04_consultCustom_1.sql', 'utf8');
            const data = await consultCustom(client, sql);

            const table = tablesWrapper(data);

            if(table === 0) return;

            console.log("");
            const chartGenerate = prompt("🎨 Deseja gerar o gráfico com os dados? (s/n): ").toLowerCase();

            if (chartGenerate === 's') {
                await chartConsult_1(data);
            }
            
        }

        if(consult_option === "2") {
            const sql = fs.readFileSync('./src/sql/05_consultCustom_2.sql', 'utf8');
            const data = await consultCustom(client, sql);

            const table = tablesWrapper(data);

            if(table === 0) return;

            console.log("");
            const chartGenerate = prompt("🎨 Deseja gerar o gráfico com os dados? (s/n): ").toLowerCase();

            if (chartGenerate === 's') {
                await chartConsult_2(data);
            }
            
        }

        if(consult_option === "3") {
            const sql = fs.readFileSync('./src/sql/06_consultCustom_3.sql', 'utf8');
            const data = await consultCustom(client, sql);

            const table = tablesWrapper(data);

            if(table === 0) return;
            console.log("");
            const chartGenerate = prompt("🎨 Deseja gerar o gráfico com os dados? (s/n): ").toLowerCase();

            if (chartGenerate === 's') {
                await chartConsult_3(data);
            }
            
        }

        await client.end();



    } catch (error) {
        await client.end();
        
        if (error.code === "42P01") {
            console.log("\n❌ ERRO: Tabelas para consulta não encontradas.");
            return;
        }
        throw error;
    }
}


module.exports = handleConsultCustom;