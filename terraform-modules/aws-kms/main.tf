resource "aws_kms_key" "custom_key" {
  count                    = var.create_kms ? 1 : 0
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  policy                   = var.policy != null && var.policy != "" ? var.policy : data.aws_iam_policy_document.kms_policy[0].json
  description              = var.description
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  tags = merge(
    var.tags,
    {
      Name = format("%s-%s", var.master_prefix, var.alias)
    }
  )
  depends_on = [
    aws_iam_service_linked_role.autoscaling
  ]
}

resource "aws_kms_alias" "custom_key" {
  count         = var.create_kms ? 1 : 0
  name          = coalesce(format("alias/%v", var.alias), format("alias/%v", join("", aws_kms_key.custom_key.*.key_id)))
  target_key_id = join("", aws_kms_key.custom_key.*.id)
}

resource "aws_iam_service_linked_role" "autoscaling" {
  count            = var.create_kms && var.create_service_linked ? 1 : 0
  custom_suffix    = var.custom_suffix
  aws_service_name = var.aws_service_name
}
