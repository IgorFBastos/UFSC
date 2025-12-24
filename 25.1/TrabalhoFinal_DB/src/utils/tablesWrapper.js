const Table = require('cli-table3');

const tablesWrapper = (rows) => {

    if (rows.length === 0) {
        console.log("\n📭 Nenhum registro encontrado.");
        return 0;
    }

    const head = Object.keys(rows[0]);

    const colWidths =  head.map(() => 20);

    const table = new Table({
        head,
        colWidths,
        wordWrap: true,
        style: {
            head: ['cyan'],
            border: ['grey']
        }
    });

    rows.forEach(row => {
        const values = head.map(key => {
            const value = row[key];
            if (value instanceof Date) {
                return value.toISOString().split('T')[0];
            }
            if (typeof value === 'string' && value.length > 18) {
                return value.slice(0, 17) + '…';
            }
            return value;
        });

        table.push(values);
    });

    console.log("\n");
    console.log(table.toString());
}


module.exports = tablesWrapper;