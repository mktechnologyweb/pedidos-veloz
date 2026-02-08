const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Serviço OK');
});

app.listen(3000, () => {
  console.log('Estoque rodando na porta 3000');
});
