variable "github_repository" {
  description = "GitHub repository name for deploy key"
  type        = string
}

variable "key_title" {
  description = "Title for the GitHub deploy key"
  type        = string
  default     = "terraform-deploy-key"
}

variable "algorithm" {
  description = "Algorithm to use for SSH key generation"
  type        = string
  default     = "RSA"
  
  validation {
    condition     = contains(["RSA", "ECDSA", "ED25519"], var.algorithm)
    error_message = "Algorithm must be one of: RSA, ECDSA, ED25519."
  }
}

variable "rsa_bits" {
  description = "Number of bits for RSA key (only used when algorithm is RSA)"
  type        = number
  default     = 4096
  
  validation {
    condition     = var.rsa_bits >= 2048
    error_message = "RSA key size must be at least 2048 bits."
  }
}

variable "read_only" {
  description = "Whether the deploy key should be read-only"
  type        = bool
  default     = false
}

variable "create_local_files" {
  description = "Whether to create local files for the SSH keys"
  type        = bool
  default     = false
}

variable "output_path" {
  description = "Path where local SSH key files should be saved (only used if create_local_files is true)"
  type        = string
  default     = "./output"
}

variable "ignore_key_changes" {
  description = "Whether to ignore changes to the SSH key after initial creation"
  type        = bool
  default     = true
}