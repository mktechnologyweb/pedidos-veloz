# Pedidos Veloz — Microsserviços com Docker e Kubernetes

## 📌 Descrição do Projeto
Este projeto demonstra a aplicação prática de conceitos de Cloud DevOps, utilizando
microsserviços, Docker, Kubernetes e CI/CD.

O sistema é composto por três microsserviços:
- Pedidos
- Pagamentos
- Estoque

---
## 🔁 CI/CD

O projeto utiliza GitHub Actions para Integração Contínua (CI).
O pipeline é acionado automaticamente a cada push na branch `main`,
realizando o build das imagens Docker dos três microsserviços:

- Pedidos
- Pagamentos
- Estoque

Esse processo garante que todos os serviços sejam validados
automaticamente a cada alteração no código.

## 🐳 Execução com Docker Compose

### Pré-requisitos
- Docker
- Docker Compose

### Subir o ambiente local
```bash
docker compose up --build
