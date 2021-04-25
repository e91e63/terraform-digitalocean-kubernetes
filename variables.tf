variable "do_conf" {
  type = object()
}

variable "k8s_conf" {
  default = {}
  type    = object()
}

local {
  k8s_conf_default = {
    name         = "k8s"
    auto_upgrade = true
    node = {
      autoscale = true
      count     = 3
      max       = 5
      min       = 3
      tags      = []
    }
    surge_upgrade  = true
    version        = "1.20"
    vpc_cidr_block = "10.20.0.0/16"
  }
  k8s_conf_merged = merge(
    local.k8s_conf_default,
    var.k8s_conf
  )
}
