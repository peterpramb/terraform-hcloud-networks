# ==========================================================
# Manages networks, routes, and subnets in the Hetzner Cloud
# ==========================================================


# ---------------
# Input Variables
# ---------------

variable "networks" {
  description = "The list of network objects to be managed. Each network object supports the following parameters: 'name' (string, required), 'ip_range' (string, required), 'routes' (list of route objects, optional), 'subnets' (list of subnet objects, required), 'labels' (map of KV pairs, optional). Each route object supports the following parameters: 'destination' (string, required), 'gateway' (string, required). Each subnet object supports the following parameters: 'ip_range' (string, required), 'network_zone' (string, required), 'type' (string, required)."

  type = list(
    object({
      name     = string
      ip_range = string
      routes   = list(
        object({
          destination = string
          gateway     = string
        })
      )
      subnets  = list(
        object({
          ip_range     = string
          network_zone = string
          type         = string
        })
      )
      labels   = map(string)
    })
  )

  default = [
    {
      name     = "network-1"
      ip_range = "10.0.0.0/16"
      routes   = null
      subnets  = [
        {
          ip_range     = "10.0.0.0/24"
          network_zone = "eu-central"
          type         = "server"
        }
      ]
      labels   = null
    }
  ]

  validation {
    condition = can([
      for network in var.networks : regex("\\w+", network.name)
    ])
    error_message = "All networks must have a valid 'name' attribute specified."
  }

  validation {
    condition = can([
      for network in var.networks : regex("[[:xdigit:]]+", network.ip_range)
    ])
    error_message = "All networks must have a valid 'ip_range' attribute specified."
  }

  validation {
    condition = can([
      for network in var.networks : [
        for route in network.routes : regex("[[:xdigit:]]+", route.destination)
      ] if lookup(network, "routes", null) != null
    ])
    error_message = "All routes must have a valid 'destination' attribute specified."
  }

  validation {
    condition = can([
      for network in var.networks : [
        for route in network.routes : regex("[[:xdigit:]]+", route.gateway)
      ] if lookup(network, "routes", null) != null
    ])
    error_message = "All routes must have a valid 'gateway' attribute specified."
  }

  validation {
    condition = can([
      for network in var.networks : element(network.subnets, 0)
    ])
    error_message = "All networks must have at least one subnet specified."
  }

  validation {
    condition = can([
      for network in var.networks : [
        for subnet in network.subnets : regex("[[:xdigit:]]+", subnet.ip_range)
      ]
    ])
    error_message = "All subnets must have a valid 'ip_range' attribute specified."
  }

  validation {
    condition = can([
      for network in var.networks : [
        for subnet in network.subnets : regex("\\w+", subnet.network_zone)
      ]
    ])
    error_message = "All subnets must have a valid 'network_zone' attribute specified."
  }

  validation {
    condition = can([
      for network in var.networks : [
        for subnet in network.subnets : regex("\\w+", subnet.type)
      ]
    ])
    error_message = "All subnets must have a valid 'type' attribute specified."
  }
}
