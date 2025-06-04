output "key_arn" {
  value       = join("", aws_kms_key.custom_key.*.arn)
  description = "KMS Key ARN"
}

output "key_id" {
  value       = join("", aws_kms_key.custom_key.*.key_id)
  description = "KMS Key ID"
}

output "alias_arn" {
  value       = join("", aws_kms_alias.custom_key.*.arn)
  description = "KMS Alias ARN"
}

output "alias_name" {
  value       = join("", aws_kms_alias.custom_key.*.name)
  description = "KMS Alias name"
}
