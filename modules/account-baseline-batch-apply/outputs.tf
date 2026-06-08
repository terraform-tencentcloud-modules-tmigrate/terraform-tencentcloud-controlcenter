output "batch_apply_id" {
  value = { for k, v in tencentcloud_batch_apply_account_baselines.baselines : k => v.id }
}
