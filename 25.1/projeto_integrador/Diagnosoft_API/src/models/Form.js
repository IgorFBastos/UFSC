const mongoose = require("mongoose");

const questionSchema = new mongoose.Schema({
    question: String,
    type: { type: String, enum: ["afirmative", "descriptive", "numeric"], required: true },
    formula: String,
    variables: [{
        name: String, 
        response: {
            type: Number,
            default: null, 
        }
    }],
    question_number: Number,
    response: mongoose.Schema.Types.Mixed,
});

const formSchema = new mongoose.Schema({
    form_name: { type: String, required: true },
    medic_name: { type: String, required: true },
    patient_name: { type: String, required: true },
    status: { type: String, enum: ["answered", "no-answered"], required: true },
    questions: [questionSchema],
    link: { type: String }
}, {
    timestamps: true
});

// Middleware para atribuir question_number automaticamente
formSchema.pre("save", function (next) {
    if (this.questions && this.questions.length > 0) {
        this.questions.forEach((q, index) => {
            q.question_number = index + 1; // começa do 1
        });
    }
    next();
});

module.exports = mongoose.model("Form", formSchema);