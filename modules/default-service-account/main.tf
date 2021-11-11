resource "digitalocean_container_registry_docker_credentials" "main" {
  registry_name = var.container_registry_info.registry_name
}

resource "kubernetes_default_service_account" "main" {
  automount_service_account_token = true
  image_pull_secret {
    name = kubernetes_secret.main.metadata[0].name
  }
  lifecycle {
    ignore_changes = [
      secret
    ]
  }
  metadata {
    namespace = var.service_account_conf.namespace
  }
}

resource "kubernetes_secret" "main" {
  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.main.docker_credentials
  }
  metadata {
    name = "docker-registry-${var.container_registry_info.registry_name}-credentials"
  }
  type = "kubernetes.io/dockerconfigjson"
}
