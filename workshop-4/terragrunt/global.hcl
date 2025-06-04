# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Configure Terragrunt to automatically store tfstate files in an S3 bucket

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    # Need to change if we apply for another account
    bucket  = "leesantee-terraform-states-us-east-1"
    region  = "us-east-1"
    encrypt = truehelm
    key     = "${path_relative_to_include()}/terraform.tfstate"
    profile = "np-monitor"
  }
}


