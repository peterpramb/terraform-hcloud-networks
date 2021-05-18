# ========================================
# Example for automatic subnet calculation
# ========================================


# ------------
# Local Values
# ------------

locals {
  # Enrich user configuration for network module:
  networks = [
    for network in var.networks : {
      "name"     = network[0]
      "ip_range" = network[1]
      "routes"   = []
      "subnets"  = [
        for index in range(var.subnet_start,
                           var.subnet_start + var.subnet_count) : {
          "ip_range"     = cidrsubnet(network[1], network[2], index)
          "network_zone" = "eu-central"
          "type"         = "cloud"
        }
      ]
      "labels"   = var.labels
    }
  ]
}


# --------
# Networks
# --------

module "network" {
  source   = "github.com/peterpramb/terraform-hcloud-networks"

  networks = local.networks
}
