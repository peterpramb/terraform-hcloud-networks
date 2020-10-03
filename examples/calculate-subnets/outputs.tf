# ========================================
# Example for automatic subnet calculation
# ========================================


# -------------
# Output Values
# -------------

output "networks" {
  description = "A list of all network objects."
  value       = module.network.networks
}
