const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = 3000;

const pool = new Pool({
  connectionString: process.env.DATABASE_URL
});

app.get('/', async (req, res) => {
  const client = await pool.connect();
  try {
    // Query for database time
    const timeResult = await client.query('SELECT NOW()');
    const dbTime = timeResult.rows[0].now;

    // Query for persons table
    const personsResult = await client.query('SELECT name, age FROM persons');
    const persons = personsResult.rows;

    // Construct the response HTML
    let responseHtml = `<h1>Database time: ${dbTime}</h1>`;
    responseHtml += '<h1>Names and Ages</h1><table border="1"><tr><th>Name</th><th>Age</th></tr>';
    persons.forEach(person => {
      responseHtml += `<tr><td>${person.name}</td><td>${person.age}</td></tr>`;
    });
    responseHtml += '</table>';

    res.send(responseHtml);
  } finally {
    client.release();
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
