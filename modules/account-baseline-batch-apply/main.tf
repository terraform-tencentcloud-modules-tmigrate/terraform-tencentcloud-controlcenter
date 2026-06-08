locals {
  member_uin_map = { for uin in var.member_uin_list : tostring(uin) => uin }
}

resource "tencentcloud_batch_apply_account_baselines" "baselines" {
  for_each = local.member_uin_map

  member_uin_list = [each.value]

  dynamic "baseline_config_items" {
    for_each = var.baseline_config_items
    content {
      identifier    = baseline_config_items.value.identifier
      configuration = baseline_config_items.value.configuration
    }
  }
}
