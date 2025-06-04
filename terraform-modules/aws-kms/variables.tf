################################################################################
# KMS Variables
################################################################################

variable "create_kms" {
  type        = bool
  default     = true
  description = "Whether to enable Key Management"
  validation {
    condition     = contains([true, false], var.create_kms)
    error_message = "Valid values for var: create_kms are `true`, `false`."
  }
}

variable "deletion_window_in_days" {
  type        = number
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled"
  validation {
    condition     = contains([true, false], var.enable_key_rotation)
    error_message = "Valid values for var: enable_key_rotation are `true`, `false`."
  }
}

variable "description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console"
}

variable "alias" {
  type        = string
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash. If not specified, the alias name will be auto-generated."
  validation {
    condition     = length(var.alias) > 0
    error_message = "Valid values for var: alias cannot be an empty string."
  }
}

variable "policy" {
  type        = string
  default     = null
  description = "A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy."
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`."
  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "SIGN_VERIFY"], var.key_usage)
    error_message = "Valid values for var: key_usage are `ENCRYPT_DECRYPT`, `SIGN_VERIFY`."
  }
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`."
  validation {
    condition     = contains(["SYMMETRIC_DEFAULT", "RSA_2048", "RSA_3072", "RSA_4096", "HMAC_256", "ECC_NIST_P256", "ECC_NIST_P384", "ECC_NIST_P521", "ECC_SECG_P256K1"], var.customer_master_key_spec)
    error_message = "Valid values for var: customer_master_key_spec are `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `HMAC_256`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521` , `ECC_SECG_P256K1`."
  }
}

variable "create_service_linked" {
  type        = bool
  default     = false
  description = "Whether to create service linked"
  validation {
    condition     = contains([true, false], var.create_service_linked)
    error_message = "Valid values for var: create_service_linked are `true`, `false`."
  }
}

variable "aws_service_name" {
  type        = string
  default     = ""
  description = "The AWS service to which this role is attached. You use a string similar to a URL but without the http:// in front. For example: elasticbeanstalk.amazonaws.com"
}

variable "custom_suffix" {
  type        = string
  default     = null
  description = "Additional string appended to the role name. Not all AWS services support custom suffixes."
}

################################################################################
# Common Variables
################################################################################

variable "master_prefix" {
  description = "To specify a key prefix for aws resource"
  type        = string
  default     = "dso"
  validation {
    condition     = length(var.master_prefix) > 0
    error_message = "Valid values for var: master_prefix cannot be an empty string."
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "AWS Region name to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS profile"
  type        = string
  default     = null
  validation {
    condition     = length(var.profile) > 0
    error_message = "Valid values for var: profile cannot be an empty string."
  }
}

# variable "assume_role" {
#   description = "AssumeRole to manage the resources within account that owns"
#   type        = string
#   default     = null
#   validation {
#     condition     = can(regex("^arn:aws:iam::[[:digit:]]{12}:role/.+", var.assume_role))
#     error_message = "Must be a valid AWS IAM role ARN."
#   }
# }
