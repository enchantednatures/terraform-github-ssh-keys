# Advanced Example

This example demonstrates advanced usage of the terraform-github-ssh-keys module with different key types and configurations.

## Features Demonstrated

- ED25519 key generation (more secure and faster than RSA)
- RSA key with custom bit size
- Local file creation for SSH keys
- Read-only vs read-write deploy keys
- Multiple deploy keys for different repositories

## Usage

1. Set your GitHub token:
   ```bash
   export GITHUB_TOKEN="your_github_token"
   ```

2. Update the repository names in `main.tf`.

3. Run Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## What this creates

- Two SSH key pairs (one ED25519, one RSA 2048-bit)
- Two GitHub deploy keys in different repositories
- Local SSH key files in `./ssh-keys/` and `./keys/` directories
- Various outputs including fingerprints for verification

## Key Types

### ED25519 (Recommended)
- More secure than RSA
- Faster key generation and verification
- Smaller key size
- Supported by modern SSH implementations

### RSA
- Widely supported
- Configurable key size (minimum 2048 bits)
- Larger key size for equivalent security

## Cleanup

```bash
terraform destroy
rm -rf ssh-keys/ keys/  # Remove local key files
```