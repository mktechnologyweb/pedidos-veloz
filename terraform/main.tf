############################################
# Terraform – Pedidos Veloz (Kubernetes)
############################################

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

############################################
# Namespace
############################################

resource "kubernetes_namespace_v1" "pedidos_veloz" {
  metadata {
    name = "pedidos-veloz"
  }
}

############################################
# ConfigMap – Pedidos
############################################

resource "kubernetes_config_map_v1" "pedidos_config" {
  metadata {
    name      = "pedidos-config"
    namespace = kubernetes_namespace_v1.pedidos_veloz.metadata[0].name
  }

  data = {
    AMBIENTE       = "producao"
    ESTOQUE_URL    = "http://estoque"
    PAGAMENTOS_URL = "http://pagamentos"
  }
}

############################################
# Secret – Pedidos
############################################

resource "kubernetes_secret_v1" "pedidos_secret" {
  metadata {
    name      = "pedidos-secret"
    namespace = kubernetes_namespace_v1.pedidos_veloz.metadata[0].name
  }

  data = {
    DB_USER     = base64encode("admin")
    DB_PASSWORD = base64encode("senha123")
  }

  type = "Opaque"
}

############################################
# Deployment – Pedidos
############################################

resource "kubernetes_deployment_v1" "pedidos" {
  metadata {
    name      = "pedidos"
    namespace = kubernetes_namespace_v1.pedidos_veloz.metadata[0].name
    labels = {
      app = "pedidos"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "pedidos"
      }
    }

    template {
      metadata {
        labels = {
          app = "pedidos"
        }
      }

      spec {
        container {
          name  = "pedidos"
          image = "${var.docker_user}/pedidos:latest"

          port {
            container_port = 3000
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map_v1.pedidos_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret_v1.pedidos_secret.metadata[0].name
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 3000
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 3000
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}

############################################
# Service – Pedidos
############################################

resource "kubernetes_service_v1" "pedidos" {
  metadata {
    name      = "pedidos"
    namespace = kubernetes_namespace_v1.pedidos_veloz.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.pedidos.metadata[0].labels.app
    }

    port {
      port        = 3000
      target_port = 3000
    }

    type = "ClusterIP"
  }
}

############################################
# HPA – Pedidos
############################################

resource "kubernetes_horizontal_pod_autoscaler_v2" "pedidos_hpa" {
  metadata {
    name      = "pedidos-hpa"
    namespace = kubernetes_namespace_v1.pedidos_veloz.metadata[0].name
  }

  spec {
    min_replicas = 2
    max_replicas = 5

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment_v1.pedidos.metadata[0].name
    }

    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type                = "Utilization"
          average_utilization = 50
        }
      }
    }
  }
}
