# terraform-digitalocean-k8s

Terraform modules for managing Kubernetes clusters in DigitalOcean.

## Kube Config

```sh
sudo snap connect doctl:kube-config
mkdir -p "$HOME/.kube"
rm -rf "$HOME/kube/*"
CLUSTER_ID=$(terragrunt output -json | jq -r '.info.value.id')
doctl kubernetes cluster kubeconfig save "$CLUSTER_ID"
```
