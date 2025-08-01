# Generate SSH key pair for GitHub authentication
resource "tls_private_key" "this" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

# Save private key locally (optional, controlled by variable)
resource "local_file" "private_key" {
  count = var.create_local_files ? 1 : 0

  content         = tls_private_key.this.private_key_pem
  filename        = "${var.output_path}/${var.key_title}"
  file_permission = "0600"
}

# Save public key locally (optional, controlled by variable)
resource "local_file" "public_key" {
  count = var.create_local_files ? 1 : 0

  content  = tls_private_key.this.public_key_openssh
  filename = "${var.output_path}/${var.key_title}.pub"
}

# Create GitHub deploy key
resource "github_repository_deploy_key" "this" {
  title      = var.key_title
  repository = var.github_repository
  key        = tls_private_key.this.public_key_openssh
  read_only  = var.read_only

  lifecycle {
    ignore_changes = var.ignore_key_changes ? [key] : []
  }
}