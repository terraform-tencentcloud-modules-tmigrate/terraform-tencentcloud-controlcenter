terraform {
  required_version = ">= 1.5.0"

  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.82.96"
    }
  }
}

data "terraform_remote_state" "baseline_config" {
  backend = "local"

  config = {
    path = "../account-baseline-config/terraform.tfstate"
  }
}

module "batch_apply" {
  source = "../../modules/account-baseline-batch-apply"

  member_uin_list = [2000000001]

  baseline_config_items = [
    for item in data.terraform_remote_state.baseline_config.outputs.baseline_config_items :
    item if contains(local.apply_identifiers, item.identifier)
  ]
}

locals {
  apply_identifiers = [
    "TCC-AF_CAM_USER_PASSWORD_POLICY",
    "TCC-AF_CAM_USER_SECURITY",
    # "TCC-AF_ACCOUNT_CONTACT",
    "TCC-AF_PRESET_TAG",
    # "TCC-AF_ACCOUNT_NOTIFICATION",
  ]
}
