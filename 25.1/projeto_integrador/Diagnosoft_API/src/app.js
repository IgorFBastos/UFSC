const express = require("express");
const cors = require("cors");
const formRoutes = require("./routes/formRoutes");

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
    res.send("API funcionando!");
});

app.use("/api/forms", formRoutes);

module.exports = app;
