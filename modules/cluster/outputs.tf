output "info" {
  sensitive = true
  value = {
    cluster_ca_certificate = digitalocean_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
    host                   = digitalocean_kubernetes_cluster.main.kube_config[0].host
    token                  = digitalocean_kubernetes_cluster.main.kube_config[0].token
  }
}
