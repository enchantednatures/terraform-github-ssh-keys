terraform {
  required_version = ">= 1.0"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
  }
}