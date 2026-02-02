const express = require('express');
const app = express();

app.get('/pedidos', (req, res) => {
  res.json({ mensagem: 'Serviço de pedidos funcionando' });
});

app.listen(3000, () => {
  console.log('Pedidos rodando na porta 3000');
});
