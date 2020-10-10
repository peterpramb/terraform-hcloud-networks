# ========================================================
# Manage networks, routes and subnets in the Hetzner Cloud
# ========================================================


# ------------
# Local Values
# ------------

locals {
  output_networks = [
    for network in hcloud_network.networks : merge(network, {
      "routes"  = [
        for route in hcloud_network_route.routes : route
          if(tostring(route.network_id) == network.id)
      ]}, {
      "subnets" = [
        for subnet in hcloud_network_subnet.subnets : subnet
          if(tostring(subnet.network_id) == network.id)
      ]
    })
  ]

  output_routes   = [
    for name, route in hcloud_network_route.routes : merge(route, {
      "name"         = name
      "network_name" = try(local.routes[name].network, null)
    })
  ]

  output_subnets  = [
    for name, subnet in hcloud_network_subnet.subnets : merge(subnet, {
      "name"         = name
      "network_name" = try(local.subnets[name].network, null)
    })
  ]
}


# -------------
# Output Values
# -------------

output "networks" {
  description = "A list of all network objects."
  value       = local.output_networks
}

output "network_ids" {
  description = "A map of all network objects indexed by ID."
  value       = {
    for network in local.output_networks : network.id => network
  }
}

output "network_names" {
  description = "A map of all network objects indexed by name."
  value       = {
    for network in local.output_networks : network.name => network
  }
}

output "network_routes" {
  description = "A list of all network route objects."
  value       = local.output_routes
}

output "network_route_ids" {
  description = "A map of all network route objects indexed by ID."
  value       = {
    for route in local.output_routes : route.id => route
  }
}

output "network_route_names" {
  description = "A map of all network route objects indexed by name."
  value       = {
    for route in local.output_routes : route.name => route
  }
}

output "network_subnets" {
  description = "A list of all network subnet objects."
  value       = local.output_subnets
}

output "network_subnet_ids" {
  description = "A map of all network subnet objects indexed by ID."
  value       = {
    for subnet in local.output_subnets : subnet.id => subnet
  }
}

output "network_subnet_names" {
  description = "A map of all network subnet objects indexed by name."
  value       = {
    for subnet in local.output_subnets : subnet.name => subnet
  }
}
