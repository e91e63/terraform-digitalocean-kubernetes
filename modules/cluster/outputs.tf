output "kubeconfig" {
  value       = digitalocean_kubernetes_cluster.master.kube_config[0].raw_config
  description = "kubeconfig"
}
