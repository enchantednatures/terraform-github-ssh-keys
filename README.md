# Terraform GitHub SSH Keys Module

A Terraform module for generating SSH key pairs and managing GitHub deploy keys for GitOps workflows.

## Features

- 🔐 Generate SSH key pairs (RSA, ECDSA, ED25519)
- 🚀 Automatically create GitHub deploy keys
- 📁 Optional local file creation for SSH keys
- 🔒 Configurable read-only or read-write access
- 🛡️ Security best practices with sensible defaults
- 📊 Multiple output formats including fingerprints

## Usage

### Basic Example

```hcl
module "github_ssh_keys" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"

  github_repository = "my-org/my-repo"
  key_title         = "flux-deploy-key"
}
```

### Advanced Example

```hcl
module "github_ssh_keys" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"

  github_repository   = "my-org/my-repo"
  key_title          = "deployment-key"
  algorithm          = "ED25519"
  read_only          = false
  create_local_files = true
  output_path        = "./ssh-keys"
}
```

## Examples

- [Basic](examples/basic) - Simple usage with default settings
- [Advanced](examples/advanced) - Multiple key types and configurations

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| tls | >= 4.0 |
| local | >= 2.4 |
| github | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| tls | >= 4.0 |
| local | >= 2.4 |
| github | >= 6.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github_repository | GitHub repository name for deploy key | `string` | n/a | yes |
| key_title | Title for the GitHub deploy key | `string` | `"terraform-deploy-key"` | no |
| algorithm | Algorithm to use for SSH key generation | `string` | `"RSA"` | no |
| rsa_bits | Number of bits for RSA key (only used when algorithm is RSA) | `number` | `4096` | no |
| read_only | Whether the deploy key should be read-only | `bool` | `false` | no |
| create_local_files | Whether to create local files for the SSH keys | `bool` | `false` | no |
| output_path | Path where local SSH key files should be saved | `string` | `"./output"` | no |


## Outputs

| Name | Description |
|------|-------------|
| private_key_pem | SSH private key in PEM format |
| public_key_openssh | SSH public key in OpenSSH format |
| public_key_fingerprint_md5 | MD5 fingerprint of the public key |
| public_key_fingerprint_sha256 | SHA256 fingerprint of the public key |
| deploy_key_id | ID of the GitHub deploy key |
| deploy_key_ready | Indicates that the GitHub deploy key has been created |

## Supported Key Algorithms

### ED25519 (Recommended)
- **Pros**: More secure, faster, smaller key size
- **Cons**: Not supported by very old SSH implementations
- **Use case**: Modern environments, recommended for new deployments

### RSA
- **Pros**: Widely supported, configurable key size
- **Cons**: Larger keys, slower operations
- **Use case**: Legacy systems, when ED25519 is not supported
- **Minimum key size**: 2048 bits (4096 recommended)

### ECDSA
- **Pros**: Good balance of security and performance
- **Cons**: Less common than RSA or ED25519
- **Use case**: When ED25519 is not available but RSA is too slow

## Security Considerations

- Private keys are marked as sensitive in Terraform state
- Default RSA key size is 4096 bits for enhanced security
- Local files are created with restrictive permissions (0600)
- Deploy keys can be configured as read-only for enhanced security
- Key changes are ignored by default to prevent accidental regeneration

## GitHub Authentication

This module requires GitHub authentication. You can authenticate using:

### Personal Access Token
```bash
export GITHUB_TOKEN="your_personal_access_token"
```

### GitHub App
```bash
export GITHUB_APP_ID="your_app_id"
export GITHUB_APP_INSTALLATION_ID="your_installation_id"
export GITHUB_APP_PEM_FILE="path/to/your/private-key.pem"
```

## Common Use Cases

### GitOps with Flux
```hcl
module "flux_ssh_keys" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"

  github_repository = "my-org/gitops-repo"
  key_title         = "flux-system"
  algorithm         = "ED25519"
  read_only         = false
}

# Use the keys with Flux
resource "kubernetes_secret" "flux_ssh" {
  metadata {
    name      = "flux-system"
    namespace = "flux-system"
  }

  type = "Opaque"

  data = {
    identity       = module.flux_ssh_keys.private_key_pem
    "identity.pub" = module.flux_ssh_keys.public_key_openssh
    known_hosts    = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
  }
}
```

### CI/CD Deployment Keys
```hcl
module "deployment_keys" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"

  github_repository = "my-org/app-repo"
  key_title         = "ci-deployment"
  read_only         = true  # Read-only for security
  algorithm         = "ED25519"
}
```

## Migration from Local Module

If you're migrating from a local module, update your module source:

```hcl
# Before
module "github_ssh_keys" {
  source = "./modules/github_ssh_keys"
  # ...
}

# After
module "github_ssh_keys" {
  source = "github.com/enchantednatures/terraform-github-ssh-keys"
  # ...
}
```

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests to our GitHub repository.

## License

This module is licensed under the Apache 2.0 License. See [LICENSE](LICENSE) for full details.

## Authors

Created and maintained by [enchantednatures](https://github.com/enchantednatures).