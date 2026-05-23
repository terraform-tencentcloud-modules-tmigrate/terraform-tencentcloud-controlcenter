variable "member_uin_list" {
  description = "Member account UIN list to apply baseline to."
  type        = list(number)
}

variable "baseline_config_items" {
  description = "List of baseline config items (identifier + configuration) to apply. Can be passed directly from baseline-config module output."
  type = list(object({
    identifier    = string
    configuration = string
  }))
}
