variable "kubernetes_conf" {
  type = object({
    auto_upgrade = optional(bool)
    description  = optional(string)
    name         = optional(string),
    node_pool_worker = object({
      autoscale              = optional(bool)
      max_nodes              = optional(number)
      min_nodes              = optional(number)
      name                   = optional(string)
      node_droplet_size_slug = string
    })
    region        = string
    surge_upgrade = optional(bool)
    version       = string
    vpc_uuid      = string
  })
}

variable "project_info" {
  type = object({
    id   = string
    name = string
  })
}
