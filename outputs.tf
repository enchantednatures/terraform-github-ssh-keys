output "private_key_pem" {
  description = "SSH private key in PEM format"
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}

output "public_key_openssh" {
  description = "SSH public key in OpenSSH format"
  value       = tls_private_key.this.public_key_openssh
}

output "public_key_fingerprint_md5" {
  description = "MD5 fingerprint of the public key"
  value       = tls_private_key.this.public_key_fingerprint_md5
}

output "public_key_fingerprint_sha256" {
  description = "SHA256 fingerprint of the public key"
  value       = tls_private_key.this.public_key_fingerprint_sha256
}

output "deploy_key_id" {
  description = "ID of the GitHub deploy key"
  value       = github_repository_deploy_key.this.id
}

output "deploy_key_ready" {
  description = "Indicates that the GitHub deploy key has been created (for dependency management)"
  value       = github_repository_deploy_key.this.id
}