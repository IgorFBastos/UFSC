
const Form = require("../models/Form");
const { evaluate } = require('mathjs');




const createForm = async (req, res) => {
    try {
        const { form_name, medic_name, patient_name, questions, status, link } = req.body;

        const newForm = new Form({ form_name, medic_name, patient_name, status, questions, link });
        const saveForm = await newForm.save();

        res.status(201).json({ message: "Formulário criado com sucesso.", formId: saveForm._id });
    } catch (err) {
        console.log("erro: ", err)
        res.status(500).json({ error: "Erro ao criar formulário." });
    }
};

const getAllforms = async (req, res) => {

    try {

        const forms = await Form.find();

        return res.status(200).json(forms);

    } catch (error) {
        console.error("Erro ao buscar formulário. ", error);
        return res.status(500).json({ message: "Erro interno do servidor ao buscar os formuláris" })
    }
}

const getForm = async (req, res) => {

    try {

        const { id } = req.params
        if (!id) {
            return res.status(400).json({ message: "ID do form não foi fornecido corretamente." });
        }
        const form = await Form.findById(id);
        if (!form) {
            return res.status(404).json({ message: "Formulário não encontrado" })
        }
        return res.status(200).json(form);

    } catch (error) {

        console.error("Erro ao buscar formulário. ", error);
        return res.status(500).json({ message: "Erro interno do servidor ao buscar o formulário" })
    }
}





const updatedForm = async (req, res) => {
    try {
        console.log("entrou no updatedForm");

        const { id } = req.params;
        const { form_name, medic_name, patient_name, status, questions, link } = req.body;

        const processedQuestions = processNumericQuestions(questions);

        const updatedDoc = await Form.findByIdAndUpdate(
            id,
            {
                form_name,
                medic_name,
                patient_name,
                status,
                questions: processedQuestions,
                link
            },
            { new: true }
        );

        if (!updatedDoc) {
            return res.status(404).json({ message: "Formulário não encontrado." });
        }

        res.status(200).json(updatedDoc);

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Erro ao atualizar formulário." });
    }
};


function processNumericQuestions(questions) {
    return questions.map((question) => {
        if (question.type === "numeric" && question.formula && question.variables?.length) {
            try {
                const scope = {};

                for (const variable of question.variables) {
                    console.log("variable.response: ", variable.response)
                    if (!variable.response) {
                        throw new Error(`Variable ${variable.name} is missing a numeric response`);
                    }
                    scope[variable.name] = variable.response;
                }

                const result = evaluate(question.formula, scope);

                return {
                    ...question,
                    response: result 
                };
            } catch (err) {
                console.error(`Erro ao processar fórmula da pergunta ${question.question_number}:`, err.message);
                return question;
            }

        }

        return question;
    });
}

module.exports = { createForm, getForm, updatedForm, getAllforms };
