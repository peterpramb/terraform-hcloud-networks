[![License](https://img.shields.io/github/license/peterpramb/terraform-hcloud-networks)](https://github.com/peterpramb/terraform-hcloud-networks/blob/master/LICENSE)
[![Latest Release](https://img.shields.io/github/v/release/peterpramb/terraform-hcloud-networks?sort=semver)](https://github.com/peterpramb/terraform-hcloud-networks/releases/latest)
[![Terraform Version](https://img.shields.io/badge/terraform-%E2%89%A5%200.13.0-623ce4)](https://www.terraform.io)


# terraform-hcloud-networks

[Terraform](https://www.terraform.io) module for managing networks, routes and subnets in the [Hetzner Cloud](https://www.hetzner.com/cloud).

It implements the following [provider](#providers) resources:

- [hcloud_network](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network)
- [hcloud_network_route](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_route)
- [hcloud_network_subnet](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet)


## Usage

```terraform
module "network" {
  source   = "github.com/peterpramb/terraform-hcloud-networks?ref=<release>"

  networks = [
    {
      name     = "network-1"
      ip_range = "10.0.0.0/16"
      routes   = [
        {
          destination = "192.168.100.0/24"
          gateway     = "10.0.0.100"
        }
      ]
      subnets  = [
        {
          ip_range     = "10.0.0.0/24"
          network_zone = "eu-central"
          type         = "server"
        }
      ]
      labels   = {
        "managed"    = "true"
        "managed_by" = "Terraform"
      }
    }
  ]
}
```

See [examples](https://github.com/peterpramb/terraform-hcloud-networks/blob/master/examples) for more usage details.


## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io) | &ge; 0.13 |


## Providers

| Name | Version |
|------|---------|
| [hcloud](https://registry.terraform.io/providers/hetznercloud/hcloud) | &ge; 1.20 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| networks | List of network objects to be managed. | list(map([*network*](#network))) | See [below](#defaults) | yes |


#### *network*

| Name | Description | Type | Required |
|------|-------------|:----:|:--------:|
| [name](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network#name) | Unique name of the network. | string | yes |
| [ip\_range](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network#ip_range) | RFC1918 range of the network. | string | yes |
| routes | List of route objects. | list(map([*route*](#route))) | no |
| subnets | List of subnet objects. | list(map([*subnet*](#subnet))) | yes |
| [labels](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network#labels) | Map of user-defined labels. | map(string) | no |


#### *route*

| Name | Description | Type | Required |
|------|-------------|:----:|:--------:|
| [destination](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_route#destination) | Destination host or network of this route. | string | yes |
| [gateway](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_route#gateway) | Gateway for the route. | string | yes |


#### *subnet*

| Name | Description | Type | Required |
|------|-------------|:----:|:--------:|
| [ip_range](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet#ip_range) | Range to allocate IPs from. | string | yes |
| [network\_zone](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet#network_zone) | Name of the network zone. | string | yes |
| [type](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet#type) | Type of the subnet. | string | yes |


### Defaults

```terraform
networks = [
  {
    name     = "network-1"
    ip_range = "10.0.0.0/16"
    routes   = []
    subnets  = [
      {
        ip_range     = "10.0.0.0/24"
        network_zone = "eu-central"
        type         = "server"
      }
    ]
    labels   = {}
  }
]
```


## Outputs

| Name | Description |
|------|-------------|
| network\_ids | Map of all network IDs and associated names. |
| network\_names | Map of all network names and associated IDs. |
| networks | List of all network objects. |
| network\_route\_ids | Map of all network route IDs and associated names. |
| network\_route\_names | Map of all network route names and associated IDs. |
| network\_routes | List of all network route objects. |
| network\_subnet\_ids | Map of all network subnet IDs and associated names. |
| network\_subnet\_names | Map of all network subnet names and associated IDs. |
| network\_subnets | List of all network subnet objects. |


### Defaults

```terraform
network_ids = {
  "157411" = "network-1"
}

network_names = {
  "network-1" = "157411"
}

networks = [
  {
    "id" = "157411"
    "ip_range" = "10.0.0.0/16"
    "labels" = {}
    "name" = "network-1"
    "routes" = []
    "subnets" = [
      {
        "gateway" = "10.0.0.1"
        "id" = "157411-10.0.0.0/24"
        "ip_range" = "10.0.0.0/24"
        "network_id" = 157411
        "network_zone" = "eu-central"
        "type" = "server"
      },
    ]
  },
]

network_route_ids = {}

network_route_names = {}

network_routes = []

network_subnet_ids = {
  "157411-10.0.0.0/24" = "network-1:10.0.0.0/24"
}

network_subnet_names = {
  "network-1:10.0.0.0/24" = "157411-10.0.0.0/24"
}

network_subnets = [
  {
    "gateway" = "10.0.0.1"
    "id" = "157411-10.0.0.0/24"
    "ip_range" = "10.0.0.0/24"
    "network_id" = 157411
    "network_name" = "network-1"
    "network_zone" = "eu-central"
    "type" = "server"
  },
]
```


## License

This module is released under the [MIT](https://github.com/peterpramb/terraform-hcloud-networks/blob/master/LICENSE) License.
