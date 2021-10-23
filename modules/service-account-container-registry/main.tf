resource "digitalocean_container_registry_docker_credentials" "main" {
  registry_name = var.container_registry_info.name
}

resource "kubernetes_default_service_account" "main" {
  automount_service_account_token = true
  image_pull_secret {
    name = kubernetes_secret.main.metadata[0].name
  }
  metadata {
    namespace = var.service_account_conf.namespace
  }
}

resource "kubernetes_secret" "main" {
  metadata {
    name = "docker-registry-${var.container_registry_info.name}-credentials"
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.main.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}
