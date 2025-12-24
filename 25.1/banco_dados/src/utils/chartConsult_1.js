const QuickChart = require('quickchart-js');

const chartConsult_1 = async (queryResponse) => {
    const open = (await import('open')).default;

    const labels = queryResponse.map(plano => plano.nome_plano);
    const data = queryResponse.map(plano => parseFloat(plano.receita_total));

    const chart = new QuickChart();

    chart
        .setWidth(800)
        .setHeight(450)
        .setBackgroundColor('white')
        .setConfig({
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Receita Total (R$)',
                    data: data,
                    backgroundColor: ['#36A2EB', '#FFCE56', '#FF6384', '#4BC0C0'],
                    borderColor: 'rgba(0, 0, 0, 0.1)',
                    borderWidth: 1
                }]
            },
            options: {
                plugins: {
                    datalabels: {
                        anchor: 'end',
                        align: 'top',
                        color: '#333',
                        font: {
                            weight: 'bold',
                            size: 14
                        },
                        formatter: (value) => {
                            return new Intl.NumberFormat('pt-BR', {
                                style: 'currency',
                                currency: 'BRL'
                            }).format(value);
                        }
                    },
                    title: {
                        display: true,
                        text: 'Receita Total Gerada por Plano',
                        font: { size: 20, weight: 'bold' },
                        padding: { top: 10, bottom: 20 }
                    },
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Valor Arrecadado (R$)',
                            font: { size: 14 }
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Tipo de Plano',
                            font: { size: 14 }
                        }
                    }
                },
                layout: {
                    padding: { top: 30, right: 20, bottom: 20, left: 20 }
                }
            }
        });

    const imagePath = 'grafico_receita_por_plano.png';


    try {
        await chart.toFile(imagePath);
        console.log(`\n✅ Gráfico salvo com sucesso como '${imagePath}'`);
        await open(imagePath);
    } catch (error) {
        console.error('❌ Erro ao comunicar com a API do QuickChart ou salvar o arquivo:', error);
    }
};

module.exports = chartConsult_1;
