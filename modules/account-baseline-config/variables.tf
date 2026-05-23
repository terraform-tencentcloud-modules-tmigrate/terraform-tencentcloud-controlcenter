variable "baseline_name" {
  description = "Baseline name, must be unique. Supports English letters, digits, Chinese characters, and symbols @, &, _, [], -. 1-25 characters."
  type        = string
}

variable "baseline_config_items" {
  description = "List of baseline config items. Each item has identifier and configuration (JSON string)."
  type = list(object({
    identifier    = string
    configuration = string
  }))
  default = []
}
