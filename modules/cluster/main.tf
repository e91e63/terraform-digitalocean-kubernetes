# resource "local_file" "kubeconfig" {
#   content         = digitalocean_kubernetes_cluster.master.kube_config[0].raw_config
#   filename        = var.kubeconfig_path
#   file_permission = "600"
# }


data "digitalocean_kubernetes_versions" "cluster" {
  version_prefix = var.k8s_version_prefix
}

# load balancer?

resource "digitalocean_kubernetes_cluster" "master" {
  name     = var.cluster_name
  region   = var.region
  vpc_uuid = digitalocean_vpc.cluster.id

  auto_upgrade  = var.auto_upgrade
  surge_upgrade = var.surge_upgrade

  version = data.digitalocean_kubernetes_versions.cluster.latest_version
  tags    = var.tags

  node_pool {
    name       = var.node_name
    size       = var.node_size
    auto_scale = var.node_autoscale
    min_nodes  = var.node_min
    max_nodes  = var.node_max
    node_count = var.node_count
    tags       = var.node_tags
  }

  depends_on = [digitalocean_vpc.cluster]
}

resource "digitalocean_vpc" "cluster" {
  name        = "cluster-${var.cluster_name}"
  region      = var.region
  ip_range    = var.vpc_ip_range
  description = "VPC on ${var.cluster_name} cluster"
}
