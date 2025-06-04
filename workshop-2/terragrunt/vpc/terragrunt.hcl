terraform {
  source = "../../../terraform-modules/aws-vpc"
}


locals {
  # Automatically load input variables
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

include {
  path   = find_in_parent_folders("global.hcl")
  expose = true
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
    profile                = local.common_vars.profile
    description            = local.common_vars.vpc.description
    name                   = local.common_vars.vpc.name
    azs                    = local.common_vars.vpc.azs
    cidr                   = local.common_vars.vpc.cidr
    public_subnets         = local.common_vars.vpc.public_subnets
    private_subnets        = local.common_vars.vpc.private_subnets
    create_igw             = true
    enable_nat_gateway     = true
    single_nat_gateway     = true
    tags                   = {
        project = "test"
        terraform = "true"
    } 
}