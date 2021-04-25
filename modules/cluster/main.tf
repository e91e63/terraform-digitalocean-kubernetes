# TODO Solve kubeconfig
# resource "local_file" "kubeconfig" {
#   content         = digitalocean_kubernetes_cluster.master.kube_config[0].raw_config
#   filename        = var.kubeconfig_path
#   file_permission = "600"
# }


data "digitalocean_kubernetes_versions" "cluster" {
  version_prefix = var.k8s_conf.version
}

# load balancer?

resource "digitalocean_kubernetes_cluster" "control_plane" {
  # depends_on = [digitalocean_vpc.cluster]

  auto_upgrade  = var.k8s_conf.auto_upgrade
  name          = var.k8s_conf.name
  region        = var.do_conf.region
  surge_upgrade = var.k8s_conf.surge_upgrade
  tags          = var.k8s_conf.tags
  version       = data.digitalocean_kubernetes_versions.cluster.latest_version
  vpc_uuid      = digitalocean_vpc.cluster.id

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

resource "digitalocean_vpc" "cluster" {
  description = var.k8s_conf.description
  ip_range    = var.k8s_conf.vpc_ip_range
  name        = var.k8s_conf.name
  region      = var.do_conf.region
}

data "digitalocean_project" "playground" {
  name = var.name
}

resource "digitalocean_droplet" "foobar" {
  name   = "example"
  size   = "512mb"
  image  = "centos-7-x64"
  region = "nyc3"
}

resource "digitalocean_project_resources" "barfoo" {
  project = data.digitalocean_project.foo.id
  resources = [
    digitalocean_droplet.foobar.urn
  ]
}
