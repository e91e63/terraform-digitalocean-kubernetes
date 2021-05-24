output "kube_config" {
  sensitive = true
  value     = module.cluster.kube_config
}
