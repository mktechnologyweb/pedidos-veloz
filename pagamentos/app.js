const express = require('express');
const app = express();

app.get('/pagamentos', (req, res) => {
  res.json({ mensagem: 'Serviço de pagamentos funcionando' });
});

app.listen(3000, () => {
  console.log('Pagamentos rodando na porta 3000');
});
