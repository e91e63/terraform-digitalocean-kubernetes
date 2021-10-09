resource "digitalocean_container_registry" "main" {
  name                   = var.container_registry_conf.name
  subscription_tier_slug = var.container_registry_conf.subscription_tier_slug
}
