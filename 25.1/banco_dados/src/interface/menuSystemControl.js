const prompt = require('prompt-sync')();
const handleCreateTables = require('../handles/handleCreateTables');
const handleDropTables = require('../handles/handleDropTables');
const handleInsertTables = require('../handles/handleInsertTables');
const handleConsultTables = require('../handles/handleConsultTables');
const handleConsultCustom = require('../handles/handleConsultCustom');
const handleGenerateInsightsIA = require('../handles/handleGenerateInsightsIA');
const handleUpdateData = require('../handles/handleUpdateData');


let stopSystem = false;


const getStopSystem = () => {
    return stopSystem;
}

const menuActions = {
    "1": {
        action: async () => {
            await handleCreateTables();
            prompt("\n⏳ Pressione ENTER para continuar...");
        }
    },
    "2": {
        action: async () => {
            await handleDropTables();
            prompt("\n⏳ Pressione ENTER para continuar...");
        }
    },
    "3": {
        action: async () => {
            const resp = await handleInsertTables();
            if(resp === "back") return;
            prompt("\n⏳ Pressione ENTER para continuar...");
        }
    },
    "4": {
        action: async () => {
            const resp = await handleConsultTables();
            if(resp === "back") return;
            prompt("\n⏳ Pressione ENTER para continuar...");
            
        }
    },
    "5": {
        action: async () => {
            const resp = await handleConsultCustom();
            if(resp === "back") return;
            prompt("\n⏳ Pressione ENTER para continuar...");
            
        }
    },
    "6": {
        action: async () => {
            const resp = await handleUpdateData();
            if(resp === "back") return;
            prompt("\n⏳ Pressione ENTER para continuar...");
            
        }
    },
    "7": {
        action: async () => {
            const resp = await handleGenerateInsightsIA();
            if(resp === "back") return;
            prompt("\n⏳ Pressione ENTER para continuar...");
            
        }
    },
    "0": {
        action: async () => {
            console.log("\n👋 Sistema finalizado!\n");
            stopSystem = true;
        }
    },
}



module.exports = { menuActions, getStopSystem };