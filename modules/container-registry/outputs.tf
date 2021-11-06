output "info" {
  sensitive = true
  value = {
    credentials_read  = digitalocean_container_registry_docker_credentials.read.docker_credentials
    credentials_write = digitalocean_container_registry_docker_credentials.write.docker_credentials
    endpoint          = digitalocean_container_registry.main.endpoint
    registry_name     = digitalocean_container_registry.main.name
    server_url        = digitalocean_container_registry.main.server_url
  }
}
