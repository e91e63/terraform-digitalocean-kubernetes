data "digitalocean_kubernetes_versions" "main" {
  version_prefix = var.k8s_conf.version
}

data "digitalocean_project" "main" {
  name = var.do_conf.project_name
}

resource "digitalocean_container_registry" "main" {
  name                   = var.do_conf.project_name
  subscription_tier_slug = "basic"
}

resource "digitalocean_container_registry_docker_credentials" "main" {
  registry_name = digitalocean_container_registry.main.name
}

resource "digitalocean_kubernetes_cluster" "main" {
  # depends_on = [digitalocean_vpc.cluster]

  auto_upgrade  = var.k8s_conf.auto_upgrade
  name          = var.k8s_conf.name
  region        = var.do_conf.region
  surge_upgrade = var.k8s_conf.surge_upgrade
  tags          = var.k8s_conf.tags
  version       = data.digitalocean_kubernetes_versions.main.latest_version
  vpc_uuid      = digitalocean_vpc.main.id

  node_pool {
    auto_scale = var.k8s_conf.node_pool_worker.autoscale
    max_nodes  = var.k8s_conf.node_pool_worker.max_nodes
    min_nodes  = var.k8s_conf.node_pool_worker.min_nodes
    name       = var.k8s_conf.node_pool_worker.name
    size       = var.k8s_conf.node_pool_worker.size
    tags       = var.k8s_conf.node_pool_worker.tags
  }
}

resource "digitalocean_project_resources" "main" {
  project = data.digitalocean_project.main.id
  resources = [
    digitalocean_kubernetes_cluster.main.urn
  ]
}

# TODO capture the default VPCs and dance around them
resource "digitalocean_vpc" "main" {
  description = var.k8s_conf.description
  ip_range    = var.k8s_conf.vpc_ip_range
  name        = var.k8s_conf.name
  region      = var.do_conf.region
}

locals {
  secret_name = "${var.do_conf.project_name}-docker-registry-credentials"
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


# resource "kubernetes_manifest" "serviceaccount_default" {
#   manifest = {
#     "apiVersion" = "v1"
#     "kind"       = "ServiceAccount"
#     "metadata" = {
#       "name"      = "default"
#       "namespace" = "default"
#     }
#     "secrets" = [
#       {
#         "name" = "default-token-ww7t8"
#       },
#     ]
#     "imagePullSecrets" = [
#       {
#         "name" = local.secret_name
#       }
#     ]
#   }
# }
