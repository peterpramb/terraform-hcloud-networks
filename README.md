[![License](https://img.shields.io/github/license/peterpramb/terraform-hcloud-networks)](https://github.com/peterpramb/terraform-hcloud-networks/blob/master/LICENSE)
[![Latest Release](https://img.shields.io/github/v/release/peterpramb/terraform-hcloud-networks?sort=semver)](https://github.com/peterpramb/terraform-hcloud-networks/releases/latest)
[![Terraform Version](https://img.shields.io/badge/terraform-%E2%89%A5%200.13.0-623ce4)](https://www.terraform.io)


# terraform-hcloud-networks

[Terraform](https://www.terraform.io) module for managing networks, routes and subnets in the [Hetzner Cloud](https://www.hetzner.com/cloud).

It implements the following [provider](#providers) resources:

- [hcloud\_network](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network)
- [hcloud\_network\_route](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_route)
- [hcloud\_network\_subnet](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet)


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
| [ip\_range](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet#ip_range) | Range to allocate IPs from. | string | yes |
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
| networks | List of all network objects. |
| network\_ids | Map of all network objects indexed by ID. |
| network\_names | Map of all network objects indexed by name. |
| network\_routes | List of all network route objects. |
| network\_route\_ids | Map of all network route objects indexed by ID. |
| network\_route\_names | Map of all network route objects indexed by name. |
| network\_subnets | List of all network subnet objects. |
| network\_subnet\_ids | Map of all network subnet objects indexed by ID. |
| network\_subnet\_names | Map of all network subnet objects indexed by name. |


### Defaults

```terraform
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

network_ids = {
  "157411" = {
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
  }
}

network_names = {
  "network-1" = {
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
  }
}

network_routes = []

network_route_ids = {}

network_route_names = {}

network_subnets = [
  {
    "gateway" = "10.0.0.1"
    "id" = "157411-10.0.0.0/24"
    "ip_range" = "10.0.0.0/24"
    "name" = "network-1:10.0.0.0/24"
    "network_id" = 157411
    "network_name" = "network-1"
    "network_zone" = "eu-central"
    "type" = "server"
  },
]

network_subnet_ids = {
  "157411-10.0.0.0/24" = {
    "gateway" = "10.0.0.1"
    "id" = "157411-10.0.0.0/24"
    "ip_range" = "10.0.0.0/24"
    "name" = "network-1:10.0.0.0/24"
    "network_id" = 157411
    "network_name" = "network-1"
    "network_zone" = "eu-central"
    "type" = "server"
  }
}

network_subnet_names = {
  "network-1:10.0.0.0/24" = {
    "gateway" = "10.0.0.1"
    "id" = "157411-10.0.0.0/24"
    "ip_range" = "10.0.0.0/24"
    "name" = "network-1:10.0.0.0/24"
    "network_id" = 157411
    "network_name" = "network-1"
    "network_zone" = "eu-central"
    "type" = "server"
  }
}
```


## License

This module is released under the [MIT](https://github.com/peterpramb/terraform-hcloud-networks/blob/master/LICENSE) License.
