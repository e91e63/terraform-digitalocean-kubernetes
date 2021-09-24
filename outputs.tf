output "cluster_id" {
  value = module.cluster.id
}

output "conf" {
  sensitive = true
  value     = module.cluster.conf
}
