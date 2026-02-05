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
# Terraform — Infraestrutura como Código

## 📌 Objetivo
Este diretório contém a estrutura básica de Terraform utilizada para
demonstrar o conceito de Infraestrutura como Código (IaC) no projeto.

## ⚙️ Justificativa Técnica
Neste trabalho, o Terraform foi utilizado em nível estrutural,
com o provider Kubernetes configurado, demonstrando como a infraestrutura
poderia ser gerenciada de forma declarativa.

A aplicação real da infraestrutura não foi realizada em ambiente de nuvem
por limitações de escopo acadêmico, sendo o foco a organização, versionamento
e padronização da infraestrutura como código.

## 📁 Estrutura
- main.tf: configuração do Terraform e provider Kubernetes
- variables.tf: variáveis reutilizáveis do projeto
