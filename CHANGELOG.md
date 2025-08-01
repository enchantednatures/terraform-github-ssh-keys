# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of terraform-github-ssh-keys module
- Support for RSA, ECDSA, and ED25519 key algorithms
- GitHub deploy key management
- Optional local file creation for SSH keys
- Configurable read-only/read-write access
- Comprehensive examples and documentation
- CI/CD workflows for validation and releases
- Security scanning with Trivy
- Automated documentation generation

### Features
- 🔐 Generate SSH key pairs with multiple algorithms
- 🚀 Automatically create GitHub deploy keys
- 📁 Optional local file creation for SSH keys
- 🔒 Configurable read-only or read-write access
- 🛡️ Security best practices with sensible defaults
- 📊 Multiple output formats including fingerprints

### Security
- Private keys marked as sensitive in Terraform state
- Default RSA key size of 4096 bits
- Local files created with restrictive permissions (0600)
- Key changes ignored by default to prevent accidental regeneration