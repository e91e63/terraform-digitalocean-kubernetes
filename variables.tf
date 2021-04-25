variable "name" {
  default = "k8s"
  type    = string
}

variable "do_conf" {
  default = {}
  type    = any
}

variable "k8s_conf" {
  default = {}
  type    = any
}
