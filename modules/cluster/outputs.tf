output "kube_config_raw" {
  sensitive = true
  value     = digitalocean_kubernetes_cluster.control_plane.kube_config[0].raw_config
}
