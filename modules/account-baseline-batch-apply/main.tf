locals {
  baseline_config_items_map = {
    for item in var.baseline_config_items : item.identifier => item
  }
}

resource "tencentcloud_batch_apply_account_baselines" "baselines" {
  for_each = local.baseline_config_items_map

  member_uin_list = var.member_uin_list

  baseline_config_items {
    identifier    = each.value.identifier
    configuration = each.value.configuration
  }
}
