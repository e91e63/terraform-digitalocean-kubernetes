# TODO Solve kubeconfig
# resource "local_file" "kubeconfig" {
#   content         = digitalocean_kubernetes_cluster.master.kube_config[0].raw_config
#   filename        = var.kubeconfig_path
#   file_permission = "600"
# }


data "digitalocean_kubernetes_versions" "main" {
  version_prefix = var.k8s_conf.version
}

# TODO load balancer

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
    node_count = var.k8s_conf.node_pool_worker.node_count
    size       = var.k8s_conf.node_pool_worker.size
    tags       = var.k8s_conf.node_pool_worker.tags
  }
}

# TODO capture the default VPCs and dance around them
resource "digitalocean_vpc" "main" {
  description = var.k8s_conf.description
  ip_range    = var.k8s_conf.vpc_ip_range
  name        = var.k8s_conf.name
  region      = var.do_conf.region
}
