const prompt = require('prompt-sync')();
const handleConfigSystem = require('./handles/handleConfigSystem');
const menuSystem = require('./interface/menuSystem');
const { menuActions, getStopSystem } = require('./interface/menuSystemControl');





const runSystem = async () => {

    try {

        await handleConfigSystem();

        prompt("\n✅ Sistema pronto. Pressione ENTER para continuar...");

        while (!getStopSystem()) {

            menuSystem();

            const option = prompt("👉 Escolha uma opção: ");
            const selected = menuActions[option];

            if (selected) {
                await selected.action();
            } else {
                console.log("❌ Opção inválida.");
            }
        }

    } catch (error) {
        console.log("Encerrando o sistema devido ao erro. ", error);
        process.exit(1);
    }
};

runSystem();