variable "namespace" {
  description = "Namespace onde os recursos Kubernetes seriam criados"
  type        = string
  default     = "default"
}

variable "app_name" {
  description = "Nome base da aplicação de microsserviços"
  type        = string
  default     = "pedidos-veloz"
}

variable "docker_user" {
  description = "mauricioodevops"
  type        = string
}