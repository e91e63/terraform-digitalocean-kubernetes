# terraform-digitalocean-k8s

Creates a Kubernetes cluster in DigitalOcean

# Kube Config

```sh
sudo snap connect doctl:kube-config
mkdir "$HOME/.kube"
CLUSTER_ID=$(terragrunt output -json | jq -r '.info.value.id')
doctl kubernetes cluster kubeconfig save "$CLUSTER_ID"
```
