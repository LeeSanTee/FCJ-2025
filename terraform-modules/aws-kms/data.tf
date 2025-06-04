
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_policy" {
  count = var.create_kms ? 1 : 0
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}
