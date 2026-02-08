const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

app.use('/pedidos', createProxyMiddleware({
  target: 'http://pedidos:3000',
  changeOrigin: true,
  pathRewrite: { '^/pedidos': '' }
}));

app.use('/pagamentos', createProxyMiddleware({
  target: 'http://pagamentos:3000',
  changeOrigin: true,
  pathRewrite: { '^/pagamentos': '' }
}));

app.use('/estoque', createProxyMiddleware({
  target: 'http://estoque:3000',
  changeOrigin: true,
  pathRewrite: { '^/estoque': '' }
}));

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.get('/', (req, res) => {
  res.send('API Gateway - Pedidos Veloz');
});

app.listen(3000, () => {
  console.log('API Gateway rodando na porta 3000');
});
