# ========================================================
# Manage networks, routes and subnets in the Hetzner Cloud
# ========================================================


# -------------
# Output Values
# -------------

output "network_ids" {
  description = "A map of all network ids and associated names."
  value       = {
    for name, network in hcloud_network.networks : network.id => name
  }
}

output "network_names" {
  description = "A map of all network names and associated ids."
  value       = {
    for name, network in hcloud_network.networks : name => network.id
  }
}

output "networks" {
  description = "A list of all network objects."
  value       = [
    for network in hcloud_network.networks : merge(network, {
        "routes"  = [
          for route in hcloud_network_route.routes : route if(tostring(route.network_id) == network.id)
        ]
      }, {
        "subnets" = [
          for subnet in hcloud_network_subnet.subnets : subnet if(tostring(subnet.network_id) == network.id)
        ]
    })
  ]
}

output "network_route_ids" {
  description = "A map of all network route ids and associated names."
  value       = {
    for name, route in hcloud_network_route.routes : route.id => name
  }
}

output "network_route_names" {
  description = "A map of all network route names and associated ids."
  value       = {
    for name, route in hcloud_network_route.routes : name => route.id
  }
}

output "network_routes" {
  description = "A list of all network route objects."
  value       = [
    for name, route in hcloud_network_route.routes : merge(route, {
      "network_name" = local.routes[name].network
    })
  ]
}

output "network_subnet_ids" {
  description = "A map of all network subnet ids and associated names."
  value       = {
    for name, subnet in hcloud_network_subnet.subnets : subnet.id => name
  }
}

output "network_subnet_names" {
  description = "A map of all network subnet names and associated ids."
  value       = {
    for name, subnet in hcloud_network_subnet.subnets : name => subnet.id
  }
}

output "network_subnets" {
  description = "A list of all network subnet objects."
  value       = [
    for name, subnet in hcloud_network_subnet.subnets : merge(subnet, {
      "network_name" = local.subnets[name].network
    })
  ]
}
