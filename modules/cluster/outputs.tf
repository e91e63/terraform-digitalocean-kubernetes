output "kube_config_raw" {
  sensitive = true
  value     = digitalocean_kubernetes_cluster.main.kube_config[0].raw_config
}
