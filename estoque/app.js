const express = require('express');
const app = express();

app.get('/estoque', (req, res) => {
  res.json({ mensagem: 'Serviço de estoque funcionando' });
});

app.listen(3000, () => {
  console.log('Estoque rodando na porta 3000');
});
