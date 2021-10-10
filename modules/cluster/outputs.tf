output "info" {
  sensitive = true
  value = {
    cluster_ca_certificate = digitalocean_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
    host                   = digitalocean_kubernetes_cluster.main.kube_config[0].host
    id                     = digitalocean_kubernetes_cluster.main.id
    token                  = digitalocean_kubernetes_cluster.main.kube_config[0].token
    worker_droplet_tag     = tolist(digitalocean_kubernetes_cluster.main.node_pool[0].tags)[0]
  }
}
