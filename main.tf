# ==========================================================
# Manages networks, routes, and subnets in the Hetzner Cloud
# ==========================================================


# ------------
# Local Values
# ------------

locals {
  # Build a map of all provided network objects, indexed by network name
  networks = {
    for network in var.networks : network.name => network
  }

  # Build a map of all provided network route objects, indexed by network
  # name and route destination
  routes = {
    for route in flatten([
      for network in local.networks : [
        for route in network.routes : merge(route, {
          "network" = network.name
        })
      ] if(lookup(network, "routes", null) != null)
    ]) : "${route.network}:${route.destination}" => route
  }

  # Build a map of all provided network subnet objects, indexed by network
  # name and subnet range
  subnets = {
    for subnet in flatten([
      for network in local.networks : [
        for subnet in network.subnets : merge(subnet, {
          "network" = network.name
        })
      ]
    ]) : "${subnet.network}:${subnet.ip_range}" => subnet
  }
}


# --------
# Networks
# --------

resource "hcloud_network" "networks" {
  for_each = local.networks

  name     = each.value.name
  ip_range = each.value.ip_range

  labels   = each.value.labels
}


# --------------
# Network Routes
# --------------

resource "hcloud_network_route" "routes" {
  for_each    = local.routes

  network_id  = hcloud_network.networks[each.value.network].id
  destination = each.value.destination
  gateway     = each.value.gateway
}


# ---------------
# Network Subnets
# ---------------

resource "hcloud_network_subnet" "subnets" {
  for_each     = local.subnets

  network_id   = hcloud_network.networks[each.value.network].id
  ip_range     = each.value.ip_range
  network_zone = each.value.network_zone
  type         = each.value.type
}
