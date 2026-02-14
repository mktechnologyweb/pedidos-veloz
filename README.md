# Video Link
https://youtu.be/hxgZ3Tz3TYA

# 🚀 Pedidos Veloz – Cloud DevOps Project

Sistema de microsserviços containerizado com Docker, orquestrado com Kubernetes e provisionado via Terraform, com pipeline CI/CD automatizado no GitHub Actions.

---

# 📌 Arquitetura do Projeto

O sistema é composto por 4 microsserviços:

* 📦 **Pedidos**
* 📦 **Estoque**
* 💳 **Pagamentos**
* 🌐 **API Gateway** (ponto de entrada)

Arquitetura baseada em:

* Microsserviços independentes
* Comunicação via HTTP
* API Gateway realizando proxy reverso
* Kubernetes para orquestração
* Terraform para provisionamento da infraestrutura
* CI/CD com GitHub Actions

---

# 🐳 Docker

Cada microsserviço possui:

* Dockerfile próprio
* Build automatizado via GitHub Actions
* Push para Docker Hub

Imagem padrão:

```
<docker_user>/nome-servico:latest
```

Exemplo:

```
mauricioodevops/pedidos:latest
```

---

# ☸️ Kubernetes

Todos os serviços são executados dentro do namespace:

```
pedidos-veloz
```

## Recursos Criados

* Namespace
* Deployment
* Service
* ConfigMap
* Secret
* HPA (Horizontal Pod Autoscaler)

---

## 🔹 Deployments

Cada microsserviço roda com:

* 2 réplicas
* Liveness Probe
* Readiness Probe
* Variáveis vindas de ConfigMap e Secret

Exemplo – Pedidos:

* Porta do container: `3000`
* Probes: `/health`

---

## 🔹 Services

| Serviço     | Tipo      | Porta Interna | NodePort |
| ----------- | --------- | ------------- | -------- |
| api-gateway | NodePort  | 3000          | 30800    |
| pedidos     | ClusterIP | 3000          | —        |
| estoque     | ClusterIP | 3000          | —        |
| pagamentos  | ClusterIP | 3000          | —        |

---

## 🔹 API Gateway

* Executa proxy reverso
* Rotas:

  * `/pedidos`
  * `/pagamentos`
  * `/estoque`
* Porta do container: **3000**

Correção aplicada:
O Service estava configurado com `targetPort: 8080`, mas o container rodava na `3000`.
Foi ajustado para `targetPort: 3000`.

---

# 📈 HPA – Auto Scaling

O serviço `pedidos` possui:

* Mínimo: 2 pods
* Máximo: 5 pods
* Métrica: CPU
* Meta: 50% de utilização

---

# 🏗️ Terraform

Infraestrutura provisionada via Terraform.

## Recursos Criados

* `kubernetes_namespace_v1`
* `kubernetes_deployment`
* `kubernetes_service`
* `kubernetes_config_map_v1`
* `kubernetes_secret_v1`
* `kubernetes_horizontal_pod_autoscaler_v2`

Provider configurado para:

```
minikube
```

## Variáveis Utilizadas

```
docker_user
```

Imagem configurada dinamicamente:

```hcl
image = "${var.docker_user}/pedidos:latest"
```

---

# 🔁 CI/CD – GitHub Actions

Pipeline automatizado contendo:

1. Checkout do código
2. Build das imagens Docker
3. Push para Docker Hub
4. Terraform Init
5. Terraform Plan
6. Terraform Apply

Secrets configurados no GitHub:

* `DOCKER_USER`
* `DOCKER_PASSWORD` (token do Docker Hub)

---

# 🖥️ Como Executar Localmente

## 1️⃣ Subir Minikube

```bash
minikube start
```

## 2️⃣ Aplicar Terraform

```bash
terraform init
terraform plan
terraform apply
```

## 3️⃣ Verificar pods

```bash
kubectl get pods -n pedidos-veloz
```

## 4️⃣ Acessar API Gateway

Opção recomendada:

```bash
minikube service api-gateway -n pedidos-veloz
```

Ou:

```bash
kubectl port-forward service/api-gateway 3000:3000 -n pedidos-veloz
```

Abrir no navegador:

```
http://localhost:3000
```

---

# 📊 Conceitos DevOps Aplicados

* Microsserviços
* Containerização
* Orquestração
* Infraestrutura como Código (IaC)
* Auto Scaling
* CI/CD
* Separação de ConfigMap e Secret
* Observabilidade via logs Kubernetes

---

# 📚 Tecnologias Utilizadas

* Node.js
* Docker
* Kubernetes
* Terraform
* GitHub Actions
* Minikube

---

# 👨‍💻 Autor

Mauricio Francesco
Projeto acadêmico – Cloud DevOps
