resource "digitalocean_container_registry" "main" {
  name                   = var.container_registry_conf.name
  subscription_tier_slug = var.container_registry_conf.subscription_tier_slug
}

resource "digitalocean_container_registry_docker_credentials" "read" {
  registry_name = digitalocean_container_registry.main.name
  write         = false
}

resource "digitalocean_container_registry_docker_credentials" "write" {
  registry_name = digitalocean_container_registry.main.name
  write         = true
}
