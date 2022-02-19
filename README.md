# DigitalOcean Kubernetes Modules

[![maintained by dmikalova](https://img.shields.io/static/v1?&color=ccff90&label=maintained%20by&labelColor=424242&logo=&logoColor=fff&message=dmikalova&&style=flat-square)](https://github.com/dmikalova)
[![terraform](https://img.shields.io/static/v1?&color=844fba&label=%20&labelColor=424242&logo=terraform&logoColor=fff&message=terraform&&style=flat-square)](https://terraform.io/)
[![digitalocean](https://img.shields.io/static/v1?&color=0080FF&label=%20&labelColor=424242&logo=digitalocean&logoColor=fff&message=digitalocean&&style=flat-square)](https://digitalocean.com/)
[![kubernetes](https://img.shields.io/static/v1?&color=326ce5&label=%20&labelColor=424242&logo=kubernetes&logoColor=fff&message=kubernetes&&style=flat-square)](https://www.kubernetes.io/)

This repo contains [Terraform modules](https://terraform.io/docs/language/modules/index.html) for managing DigitalOcean [kubernetes clusters](https://docs.digitalocean.com/products/kubernetes/) and [container registry](https://docs.digitalocean.com/products/container-registry/).

## Kube Config

A kube config can be generated using [doctl](https://github.com/digitalocean/doctl):

```sh
rm -rf "$HOME/.kube"
mkdir --parent "$HOME/.kube"
CLUSTER_ID=$(terragrunt output -json | jq -r '.info.value.id')
doctl kubernetes cluster kubeconfig save "$CLUSTER_ID"
```
