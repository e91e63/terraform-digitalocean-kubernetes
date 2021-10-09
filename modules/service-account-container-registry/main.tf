locals {
  secret_name = "${var.container_registry_info.name}-docker-registry-credentials"
}

resource "digitalocean_container_registry_docker_credentials" "main" {
  registry_name = var.container_registry_info.name
}

resource "kubernetes_secret" "main" {
  metadata {
    name = local.secret_name
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.main.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_service_account" "serviceaccount_default" {
  automount_service_account_token = false
  metadata {
    name      = "default"
    namespace = "default"
  }

  image_pull_secret {
    name = local.secret_name
  }
}
