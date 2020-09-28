# ===========================================
# Example to manage multiple networks at once
# ===========================================


# ---------------------
# Environment Variables
# ---------------------

# Hetzner Cloud Project API Token
# HCLOUD_TOKEN="<api_token>"


# ---------------
# Input Variables
# ---------------

variable "networks" {
  description = "The list of network objects to be managed. Each network object supports the following parameters: `name' (string, required), 'ip_range' (string, required), 'subnet' (string, required)."
  type        = list(
    object({
      name     = string
      ip_range = string
      subnet   = string
    })
  )
  default     = [
    {
      name     = "kube-internal"
      ip_range = "10.40.0.0/13"
      subnet   = "10.40.0.0/24"
    },
    {
      name     = "lb-internal"
      ip_range = "10.10.10.0/24"
      subnet   = "10.10.10.0/24"
    }
  ]

  validation {
    condition     = can([
      for network in var.networks : regex("\\w+", network.name)
    ])
    error_message = "All networks must have a valid 'name' attribute specified."
  }

  validation {
    condition     = can([
      for network in var.networks : regex("[[:xdigit:]]+", network.ip_range)
    ])
    error_message = "All networks must have a valid 'ip_range' attribute specified."
  }

  validation {
    condition     = can([
      for network in var.networks : regex("[[:xdigit:]]+", network.subnet)
    ])
    error_message = "All networks must have a valid 'subnet' attribute specified."
  }
}

variable "labels" {
  description = "The map of labels to be assigned to all managed resources."
  type        = map(string)
  default     = {
    "managed"    = "true"
    "managed_by" = "Terraform"
  }
}
