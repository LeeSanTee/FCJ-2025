provider "aws" {
  region = var.aws_region
  profile = var.profile
  
  # assume_role {
  #   role_arn = var.assume_role
  # }
}
