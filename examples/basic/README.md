# Basic Example

This example demonstrates the basic usage of the terraform-github-ssh-keys module.

## Usage

1. Set your GitHub token:
   ```bash
   export GITHUB_TOKEN="your_github_token"
   ```

2. Update the `github_repository` variable in `main.tf` to point to your repository.

3. Run Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## What this creates

- An RSA 4096-bit SSH key pair
- A GitHub deploy key in the specified repository with write access
- Outputs the public key for verification

## Cleanup

```bash
terraform destroy
```