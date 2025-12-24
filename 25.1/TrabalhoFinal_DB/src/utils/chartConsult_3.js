const QuickChart = require('quickchart-js');

const chartConsult_3 = async (queryResponse) => {
    const open = (await import('open')).default;

    const labels = queryResponse.map(item => item.nome_aluno);
    const data = queryResponse.map(item => parseInt(item.frequencia_total, 10));

    const maxValue = Math.max(...data);

    const chart = new QuickChart();

    chart
        .setWidth(900)
        .setHeight(500)
        .setBackgroundColor('white')
        .setConfig({
            type: 'bar', 
            options: {
                plugins: {
                    title: {
                        display: true,
                        text: 'Top 10 Alunos Mais Frequentes com Assinatura Ativa',
                        font: { size: 20, weight: 'bold' },
                        padding: { top: 10, bottom: 20 }
                    },
                    legend: {
                        display: false
                    },
                    datalabels: {
                        anchor: 'end',
                        align: 'top',
                        color: '#333',
                        font: { weight: 'bold' },
                        formatter: (value) => `${value} visitas`
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: maxValue + 10, 
                        ticks: {
                            precision: 0 
                        },
                        title: {
                            display: true,
                            text: 'Número de Visitas',
                            font: { size: 14 }
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Aluno',
                            font: { size: 14 }
                        }
                    }
                },
                layout: {
                    padding: { top: 30, right: 20, bottom: 20, left: 20 }
                }
            },
            data: {
                labels: labels,
                datasets: [{
                    label: 'Total de Visitas',
                    data: data,
                    backgroundColor: '#9966FF' 
                }]
            }
        });

    const imagePath = 'grafico_frequencia_ativos.png';

    try {
        await chart.toFile(imagePath);
        console.log(`\n✅ Gráfico salvo com sucesso como '${imagePath}'`);
        await open(imagePath);
    } catch (error) {
        console.error('❌ Erro ao comunicar com a API do QuickChart ou salvar o arquivo:', error);
    }
};

module.exports = chartConsult_3;
