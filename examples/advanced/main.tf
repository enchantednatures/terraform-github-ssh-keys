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
  # Configuration will be provided via environment variables
}

# Advanced usage with custom configuration
module "github_ssh_keys_ed25519" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"

  github_repository    = "my-org/my-repo"
  key_title           = "flux-ed25519-key"
  algorithm           = "ED25519"
  read_only           = false
  create_local_files  = true
  output_path         = "./ssh-keys"
  ignore_key_changes  = false
}

# Example with RSA key and local file creation
module "github_ssh_keys_rsa_with_files" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"

  github_repository   = "my-org/another-repo"
  key_title          = "deployment-key-rsa"
  algorithm          = "RSA"
  rsa_bits           = 2048
  read_only          = true
  create_local_files = true
  output_path        = "./keys"
}

# Outputs
output "ed25519_public_key" {
  description = "ED25519 public key"
  value       = module.github_ssh_keys_ed25519.public_key_openssh
}

output "ed25519_fingerprint" {
  description = "ED25519 key fingerprint"
  value       = module.github_ssh_keys_ed25519.public_key_fingerprint_sha256
}

output "rsa_public_key" {
  description = "RSA public key"
  value       = module.github_ssh_keys_rsa_with_files.public_key_openssh
}

output "rsa_fingerprint" {
  description = "RSA key fingerprint"
  value       = module.github_ssh_keys_rsa_with_files.public_key_fingerprint_sha256
}