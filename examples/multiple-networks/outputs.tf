# ===========================================
# Example to manage multiple networks at once
# ===========================================


# -------------
# Output Values
# -------------

output "networks" {
  description = "A list of all network objects."
  value       = module.network.networks
}
