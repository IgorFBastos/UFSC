
import express from 'express';

const app = express();

app.use(express.json());
app.use(express.static('public'));



app.get("/eventsse", (req, res) => {

    const interval = setInterval(() => {
        const time = new Date().toLocaleTimeString('pt-BR', {
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        // Formato de SSE
        res.write(`data: ${time}\n\n`);
    }, 3000);

    res.writeHead(200, {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive'
    });

    req.on('close', () => {
        clearInterval(interval);
        res.end();
    }); 
   
})

app.listen(4054, () => {
    console.log('Server is running on port 4054');

});