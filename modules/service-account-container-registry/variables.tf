variable "container_registry_info" {
  type = object({
    name = string
  })
}

variable "service_account_conf" {
  default = { namespace = "default" }
  type = object({
    namespace = string
  })
}
