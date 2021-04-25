variable "k8s_conf" {
  type = object({
    name         = string,
    auto_upgrade = bool
    node = object({
      autoscale = bool
      count     = number
      max       = number
      min       = number
      tags      = list(string)
    })
    surge_upgrade  = bool
    vpc_cidr_block = string
    version        = string
  })
}

# https://slugs.do-api.dev/
variable "do_conf" {
  default = {
    node_droplet_size_slug = "s-2vcpu-2gb"
    region                 = "sfo2"
  }
  type = object({
    node_droplet_size_slug = string
    region                 = string
  })
}

# variable "kubeconfig_path" {
#   type        = string
#   default     = "./kubeconfig"
#   description = "Kubeconfig path"
# }
