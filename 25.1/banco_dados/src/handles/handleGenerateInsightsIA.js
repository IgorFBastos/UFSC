
const OpenAI = require('openai');
const fs = require('fs');
const prompt = require('prompt-sync')();
require('dotenv').config();



const consultIA = async (schemaDB, userAsk) => {

    const openai = new OpenAI();

    const systemPrompt = "Você é um assistente de IA especialista em análise de dados e estratégia de negócios para academias. Forneça respostas claras e diretas baseadas no esquema do banco de dados fornecido.";


    const userPrompt = `
    Contexto: Eu tenho um banco de dados de uma academia com o seguinte esquema SQL:
    --- ESQUEMA ---
    ${schemaDB}
    --- FIM DO ESQUEMA ---

    Com base nesse contexto, responda à seguinte pergunta:

    Pergunta: "${userAsk}"
    `;

    try {
        const completion = await openai.chat.completions.create({
            model: 'gpt-4o-mini',
            messages: [
                { role: 'system', content: systemPrompt },
                { role: 'user', content: userPrompt }
            ],
            temperature: 0.5,
            max_tokens: 1000,
        });

        const respostaDaIA = completion.choices[0].message.content;
        return respostaDaIA;

    } catch (error) {
        console.error('❌ Erro ao se comunicar com a API da OpenAI:', error.message);
        return "Desculpe, não foi possível processar sua pergunta no momento.";
    }

}



const handleGenerateInsightsIA = async () => {

    const schemaDB = fs.readFileSync('./src/sql/01_createTables.sql', 'utf8');

    console.clear();

    console.log("\n⚙️ ASSISTENTE DE ANÁLISE ESTRATÉGICA (IA) \n");

    console.log("Bem-vindo! Faça uma pergunta em linguagem natural sobre a estrutura do seu negócio.\n");
    console.log("A IA usará o esquema do banco de dados para fornecer insights, gerar consultas SQL ou sugerir estratégias.\n");
    console.log('Exemplos: "Sugira uma campanha para reter alunos" ou "Crie um SQL para ver os planos mais lucrativos".\n');


    while (true) {

        const ask = prompt("👉 Digite sua pergunta (ou 'sair' para voltar): ");

        if (ask.toLowerCase() === 'sair' || ask === '0') {
            console.log("\nVoltando ao menu principal...");
            return "back";
        }

        if (ask.trim().length < 5) {
            console.log("Por favor, digite uma pergunta mais detalhada.\n");
            continue;
        }


        console.log("\n🧠 Analisando sua pergunta e consultando a IA... Por favor, aguarde.");

        const response = await consultIA(schemaDB, ask);

        if (response) {
            console.log("\n💡 Resposta da IA:\n");
            console.log(response);
            console.log("\n------------------------------------------------------\n");
        } else {
            console.log("\n❌ Desculpe, não foi possível obter uma resposta. Verifique o erro acima e sua conexão.\n");
        }
    }

}


module.exports = handleGenerateInsightsIA;