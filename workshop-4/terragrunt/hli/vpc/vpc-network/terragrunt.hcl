# terraform {
#   source = "git::https://${get_env("GITHUB_BOT_USER")}:${get_env("GITHUB_BOT_PRIVATE_TOKEN")}@github.com/LeeSanTee/aws-vpc.git?ref=main"
# }

# locals {
#   # Automatically load input variables
#   common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
# }

# # Include all settings from the root terraform.tfvars file
# include {
#   path = find_in_parent_folders("global.hcl")
#   expose = true
# }

# # ---------------------------------------------------------------------------------------------------------------------
# # MODULE PARAMETERS
# # These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# # ---------------------------------------------------------------------------------------------------------------------
# inputs = merge(
#   local.common_vars.inputs,
#   {
#     vpc_name               = "ingress"
#     cidr                   = "172.16.160.0/20"
#     public_subnets         = ["172.16.172.0/24", "172.16.173.0/24", "172.16.174.0/24"]
#     private_subnets        = ["172.16.160.0/22", "172.16.164.0/22", "172.16.168.0/22"]
#     create_igw             = true
#     enable_nat_gateway     = true
#     single_nat_gateway     = true
#     one_nat_gateway_per_az = false
#     enable_vpn_gateway     = false
#     # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
#     enable_flow_log                                 = false
#     create_flow_log_cloudwatch_log_group            = false
#     create_flow_log_cloudwatch_iam_role             = false
#     flow_log_max_aggregation_interval               = 60
#     flow_log_cloudwatch_log_group_retention_in_days = 30
#     # Public IP
#     map_public_ip_on_launch                         = false
#     enable_dns_hostnames                            = true
#     enable_dns_support                              = true
#     private_subnet_tags = {
#       "kubernetes.io/role/internal-elb" = 1
#     }
#     public_subnet_tags = {
#       "kubernetes.io/role/elb" = 1
#     }
#     create_vpc_attachment                  = true
#     transit_gateway_id                     = local.common_vars.inputs.tgw_id
#     enable_transit_route_for_public_subnet = true
#     tgw_destination_cidr_blocks_of_public_subnets = [
#       "172.16.0.0/12"
#     ]
#   }
# )
