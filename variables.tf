variable "do_conf" {
  default = {}
  type    = any
}

variable "k8s_conf" {
  default = {}
  type    = any
}

variable "project_info" {
  type = object({
    id   = string
    name = string
  })
}
