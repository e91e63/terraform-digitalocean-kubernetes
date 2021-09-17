locals {
  do_conf_default = {
    # https://slugs.do-api.dev/
    node_droplet_size_slug = "s-2vcpu-2gb"
    project_name           = var.name
    region                 = "sfo2"
  }

  do_conf_merged = merge(
    local.do_conf_default,
    var.do_conf,
  )

  k8s_conf_default = {
    auto_upgrade = true
    description  = "${var.name} Kubernetes cluster"
    name         = "${var.name}-k8s-cluster"
    node_pool_worker = {
      autoscale = true
      max_nodes = 5
      min_nodes = 1
      name      = "${var.name}-k8s-worker"
      size      = local.do_conf_merged.node_droplet_size_slug
      tags      = []
    }
    surge_upgrade = true
    tags          = []
    version       = "1.21"
    vpc_ip_range  = null
  }

  k8s_conf_merged = merge(
    local.k8s_conf_default,
    var.k8s_conf,
  )
}

module "cluster" {
  source = "./modules/cluster"

  do_conf  = local.do_conf_merged
  k8s_conf = local.k8s_conf_merged
}
