locals {
  secret_name = "docker-registry-${var.container_registry_info.name}-credentials"
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

resource "kubernetes_default_service_account" "main" {
  automount_service_account_token = false
  image_pull_secret {
    name = local.secret_name
  }
  metadata {
    namespace = var.service_account_conf.namespace
  }
}
