const QuickChart = require('quickchart-js');

const chartConsult_2 = async (queryResponse) => {
    const open = (await import('open')).default;

    const labels = queryResponse.map(item => item.nome_instrutor);
    const data = queryResponse.map(item => parseInt(item.total_aulas, 10));
    const maxValue = Math.max(...data);

    const chart = new QuickChart();

    chart
        .setWidth(800)
        .setHeight(600)
        .setBackgroundColor('white')
        .setConfig({
            type: 'bar',
            options: {
                indexAxis: 'y',
                plugins: {
                    title: {
                        display: true,
                        text: 'Total de Aulas Ministradas por Instrutor',
                        font: { size: 20, weight: 'bold' },
                        padding: { top: 10, bottom: 20 }
                    },
                    legend: {
                        display: false
                    },
                    datalabels: {
                        anchor: 'end',
                        align: 'right',
                        padding: { right: 6 },
                        color: '#333',
                        font: {
                            weight: 'bold'
                        },
                        formatter: (value) => `${value} aulas`
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        max: maxValue + 1,
                        ticks: {
                            stepSize: 1 
                        },
                        title: {
                            display: true,
                            text: 'Número de Aulas',
                            font: { size: 14 }
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Instrutor',
                            font: { size: 14 }
                        }
                    }
                },
                layout: {
                    padding: { top: 20, right: 40, bottom: 20, left: 20 }
                }
            },
            data: {
                labels: labels,
                datasets: [{
                    label: 'Total de Aulas',
                    data: data,
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'],
                    borderColor: 'rgba(0, 0, 0, 0.1)',
                    borderWidth: 1
                }]
            }
        });

    const imagePath = 'grafico_aulas_por_instrutor.png';

    try {
        await chart.toFile(imagePath);
        console.log(`\n✅ Gráfico salvo com sucesso como '${imagePath}'`);
        await open(imagePath);
    } catch (error) {
        console.error('❌ Erro ao comunicar com a API do QuickChart ou salvar o arquivo:', error);
    }
};

module.exports = chartConsult_2;
