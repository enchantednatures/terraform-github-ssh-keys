terraform {
  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
  }
}

# Configure the GitHub provider
provider "github" {
  # Configuration will be provided via environment variables:
  # GITHUB_TOKEN or GITHUB_APP_*
}

# Basic usage example
module "github_ssh_keys" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"

  github_repository = "my-org/my-repo"
  key_title         = "flux-deploy-key"
}

# Output the public key for verification
output "public_key" {
  description = "The generated SSH public key"
  value       = module.github_ssh_keys.public_key_openssh
}