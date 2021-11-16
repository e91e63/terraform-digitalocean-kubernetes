data "digitalocean_kubernetes_versions" "main" {
  version_prefix = local.kubernetes_conf.version
}

locals {
  # TODO: Place tags here once optional works with lists
  kubernetes_conf = defaults(var.kubernetes_conf, {
    auto_upgrade = true
    description  = "${var.project_info.name} Kubernetes cluster"
    name         = "${var.project_info.name}-k8s-cluster"
    node_pool_worker = {
      autoscale = true
      max_nodes = 5
      min_nodes = 3
      name      = "${var.project_info.name}-k8s-worker"
    }
    surge_upgrade = true
  })
}

resource "digitalocean_kubernetes_cluster" "main" {
  auto_upgrade = local.kubernetes_conf.auto_upgrade
  name         = local.kubernetes_conf.name
  node_pool {
    auto_scale = local.kubernetes_conf.node_pool_worker.autoscale
    max_nodes  = local.kubernetes_conf.node_pool_worker.max_nodes
    min_nodes  = local.kubernetes_conf.node_pool_worker.min_nodes
    name       = local.kubernetes_conf.node_pool_worker.name
    size       = local.kubernetes_conf.node_pool_worker.node_droplet_size_slug
    tags       = ["${var.project_info.name}-k8s-worker"]
  }
  region        = local.kubernetes_conf.region
  surge_upgrade = local.kubernetes_conf.surge_upgrade
  tags          = ["${var.project_info.name}-k8s-cluster"]
  version       = data.digitalocean_kubernetes_versions.main.latest_version
  vpc_uuid      = local.kubernetes_conf.vpc_uuid
}

resource "digitalocean_project_resources" "main" {
  project = var.project_info.id
  resources = [
    digitalocean_kubernetes_cluster.main.urn
  ]
}

terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2"
    }
  }
  required_version = "~> 1"
}
