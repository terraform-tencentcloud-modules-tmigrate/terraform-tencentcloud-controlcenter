output "baseline_id" {
  value = tencentcloud_controlcenter_account_factory_baseline_config.this.id
}

output "baseline_config_items" {
  description = "All baseline config items (identifier + configuration), can be passed directly to batch-apply module."
  value = var.baseline_config_items
}

output "config_by_identifier" {
  description = "Configuration grouped by identifier, for selective reference."
  value = {
    for item in var.baseline_config_items : item.identifier => item.configuration
  }
}
