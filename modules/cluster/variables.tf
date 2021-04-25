# https://slugs.do-api.dev/
variable "do_conf" {
  type = object({
    node_droplet_size_slug = string
    region                 = string
  })
}

# https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#argument-reference
variable "k8s_conf" {
  type = object({
    auto_upgrade = bool
    description  = string
    name         = string,
    node_pool_worker = object({
      autoscale  = bool
      max_nodes  = number
      min_nodes  = number
      name       = string
      node_count = number
      size       = string
      tags       = list(string)
    })
    surge_upgrade = bool
    tags          = list(string)
    version       = string
    vpc_ip_range  = string
  })
}


# variable "kubeconfig_path" {
#   type        = string
#   default     = "./kubeconfig"
#   description = "Kubeconfig path"
# }
