const app = require("./app");
const connectDB = require("./db/db");

const PORT = process.env.PORT || 5000;

require("dotenv").config();

connectDB().then(() => {
    app.listen(PORT, () => {
        console.log(`🚀 Servidor rodando na porta ${PORT}`);
    });
});
