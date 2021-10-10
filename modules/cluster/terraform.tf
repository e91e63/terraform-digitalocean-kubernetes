terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.11.1"
    }
  }
  required_version = "~> 1"
}
