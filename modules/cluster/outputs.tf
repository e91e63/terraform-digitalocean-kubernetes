output "kube_config" {
  sensitive = true
  value     = digitalocean_kubernetes_cluster.main.kube_config[0]
}

output "id" {
  value = digitalocean_kubernetes_cluster.main.id
}
