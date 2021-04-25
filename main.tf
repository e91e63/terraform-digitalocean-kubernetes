local {

}

module "cluster" {
  source = "./modules/cluster"

  do_conf  = var.do_conf
  k8s_conf = local.k8s_conf_merged
}
