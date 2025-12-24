// routes/formRoutes.js
const express = require("express");
const router = express.Router();
const { createForm, getForm, updatedForm, getAllforms} = require("../controllers/formController");


router.get("/list/all", getAllforms);
router.post("/create", createForm);
router.get("/list/:id", getForm);
router.put("/update/:id", updatedForm);


module.exports = router;
