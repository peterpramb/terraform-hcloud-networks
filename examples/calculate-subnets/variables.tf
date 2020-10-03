# ========================================
# Example for automatic subnet calculation
# ========================================


# ---------------------
# Environment Variables
# ---------------------

# Hetzner Cloud Project API Token
# HCLOUD_TOKEN="<api_token>"


# ---------------
# Input Variables
# ---------------

variable "networks" {
  description = "The list of networks to be managed, with each list element being a tuple of (name/ip_range/subnet_bits)."
  type        = list(tuple([string, string, number]))
  default     = [
    ["cl-internal", "10.20.0.0/22", 6],
    ["lb-internal", "10.10.0.0/16", 8]
  ]

  validation {
    condition     = can([
      for network in var.networks : regex("\\w+", network[0])
    ])
    error_message = "All networks must have a valid name specified."
  }

  validation {
    condition     = can([
      for network in var.networks : regex("[[:xdigit:]]+", network[1])
    ])
    error_message = "All networks must have a valid ip_range specified."
  }

  validation {
    condition     = can([
      for network in var.networks : regex("[[:digit:]]+", network[2])
    ])
    error_message = "All networks must have valid subnet_bits specified."
  }
}

variable "subnet_start" {
  description = "Which subnet offset to start at."
  type        = number
  default     = 1
}

variable "subnet_count" {
  description = "The number of subnets to create."
  type        = number
  default     = 2
}

variable "labels" {
  description = "The map of labels to be assigned to all managed resources."
  type        = map(string)
  default     = {
    "managed"    = "true"
    "managed_by" = "Terraform"
  }
}
