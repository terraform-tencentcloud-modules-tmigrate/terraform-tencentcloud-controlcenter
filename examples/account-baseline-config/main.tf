terraform {
  required_version = ">= 1.5.0"

  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.82.96"
    }
  }
}

# ─── 基线项参数 ───

locals {
  cam_password = {
    MustContain         = "1!aA"
    MinimumLength       = 12
    ForcePasswordChange = 0
    ReusePasswordLimit  = 1
    RetryPasswordLimit  = 10
  }

  cam_security = {
    DefaultMFASettings = {
      LoginDetail    = ["Stoken", "U2FToken", "Phone", "Mail"]
      LoginStrategy  = 1
      ActionStrategy = 2
    }
    LoginStatusSettings = {
      IdleSessionTimeout = 900
      SessionTimeout     = 28800
    }
  }

  account_contact = {
    AccountContacts = [
    #   {
    #     Name        = "efg"
    #     PhoneNum    = "1760000000"
    #     CountryCode = "86"
    #     Email       = "ha@163.com"
    #     Remark      = ""
    #     PhoneFlag   = 0
    #     EmailFlag   = 3
    #   },
    #   {
    #     Name        = "abc"
    #     PhoneNum    = "13403618426"
    #     CountryCode = "86"
    #     Email       = "hao@tencent.com"
    #     Remark      = ""
    #     PhoneFlag   = 0
    #     EmailFlag   = 0
    #   }
    ]
  }

  tag_info = {
    TagValuePairs = [
    #   { Key = "test", Values = ["qa"] }
    ]
  }

  account_notification = {}

  # ─── 组装 baseline_config_items ───

  baseline_config_items = [
    { identifier = "TCC-AF_CAM_USER_PASSWORD_POLICY", configuration = jsonencode(local.cam_password) },
    { identifier = "TCC-AF_CAM_USER_SECURITY",        configuration = jsonencode(local.cam_security) },
    { identifier = "TCC-AF_ACCOUNT_CONTACT",           configuration = jsonencode(local.account_contact) },
    { identifier = "TCC-AF_PRESET_TAG",             configuration = jsonencode(local.tag_info) },
    { identifier = "TCC-AF_ACCOUNT_NOTIFICATION", configuration = jsonencode(local.account_notification) },
  ]
}

module "baseline_config" {
  source = "../../modules/account-baseline-config"

  baseline_name         = "default"
  baseline_config_items = local.baseline_config_items
}

output "baseline_id" {
  value = module.baseline_config.baseline_id
}

output "baseline_config_items" {
  value = module.baseline_config.baseline_config_items
}

output "config_by_identifier" {
  value = module.baseline_config.config_by_identifier
}
