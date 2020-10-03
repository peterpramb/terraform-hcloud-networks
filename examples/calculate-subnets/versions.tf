# ========================================
# Example for automatic subnet calculation
# ========================================


# -------------------
# Module Dependencies
# -------------------

terraform {
  required_version = ">= 0.13"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.20"
    }
  }
}
