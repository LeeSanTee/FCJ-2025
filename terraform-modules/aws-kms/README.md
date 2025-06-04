# Terraform AWS KMS
Terraform module to provision a KMS key with alias.

## Usage

```hcl
module "kms" {
    description             = "KMS key"
    deletion_window_in_days = 10
    enable_key_rotation     = true
    alias                   = "common-key"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.96.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.96.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_kms_alias.custom_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.custom_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | The display name of the alias. The name must start with the word `alias` followed by a forward slash. If not specified, the alias name will be auto-generated. | `string` | n/a | yes |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | AssumeRole to manage the resources within account that owns | `string` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region name to deploy resources. | `string` | `"us-east-1"` | no |
| <a name="input_aws_service_name"></a> [aws\_service\_name](#input\_aws\_service\_name) | The AWS service to which this role is attached. You use a string similar to a URL but without the http:// in front. For example: elasticbeanstalk.amazonaws.com | `string` | `""` | no |
| <a name="input_create_kms"></a> [create\_kms](#input\_create\_kms) | Whether to enable Key Management | `bool` | `true` | no |
| <a name="input_create_service_linked"></a> [create\_service\_linked](#input\_create\_service\_linked) | Whether to create service linked | `bool` | `false` | no |
| <a name="input_custom_suffix"></a> [custom\_suffix](#input\_custom\_suffix) | Additional string appended to the role name. Not all AWS services support custom suffixes. | `string` | `null` | no |
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource | `number` | `10` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console | `string` | `"Parameter Store KMS master key"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_master_prefix"></a> [master\_prefix](#input\_master\_prefix) | To specify a key prefix for aws resource | `string` | `"dso"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias_arn"></a> [alias\_arn](#output\_alias\_arn) | KMS Alias ARN |
| <a name="output_alias_name"></a> [alias\_name](#output\_alias\_name) | KMS Alias name |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | KMS Key ARN |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | KMS Key ID |
