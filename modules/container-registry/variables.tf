variable "container_registry_conf" {
  type = object({
    name                   = string
    subscription_tier_slug = string
  })
}
