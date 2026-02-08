const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Serviço OK');
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(3000, () => {
  console.log('Pedidos rodando na porta 3000');
});
