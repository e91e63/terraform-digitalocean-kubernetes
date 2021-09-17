output "kube_config" {
  sensitive = true
  value     = module.cluster.kube_config
}

output "cluster_id" {
  value = module.cluster.id
}
