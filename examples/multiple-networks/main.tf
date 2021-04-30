# ===========================================
# Example to manage multiple networks at once
# ===========================================


# ------------
# Local Values
# ------------

locals {
  # Enrich user configuration for network module
  networks = [
    for network in var.networks : merge(network, {
      "routes"  = []
      "subnets" = [{
        "ip_range"     = network.subnet
        "network_zone" = "eu-central"
        "type"         = "cloud"
      }]
      "labels"  = var.labels
    })
  ]
}


# --------
# Networks
# --------

module "network" {
  source   = "github.com/peterpramb/terraform-hcloud-networks"

  networks = local.networks
}
