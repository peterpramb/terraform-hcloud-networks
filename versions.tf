# ========================================================
# Manage networks, routes and subnets in the Hetzner Cloud
# ========================================================


# -------------------
# Module Dependencies
# -------------------

terraform {
  required_version = ">= 0.13"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.31"
    }
  }
}
