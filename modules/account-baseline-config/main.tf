resource "tencentcloud_controlcenter_account_factory_baseline_config" "this" {
  name = var.baseline_name

  dynamic "baseline_config_items" {
    for_each = var.baseline_config_items
    content {
      identifier    = baseline_config_items.value.identifier
      configuration = baseline_config_items.value.configuration
    }
  }
}
