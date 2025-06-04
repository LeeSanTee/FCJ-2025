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
#   local.common_vars,
#   {
#     vpc_name         = local.common_vars.inputs.application
#     # 172.16.128.0 -> 172.16.143.255 = 4,096 hosts
#     cidr             = "172.16.128.0/20"
#     # 172.16.132.0/22: 172.16.132.0 -> 172.16.135.255 = 1,024 hosts
#     # 172.16.136.0/22: 172.16.136.0 -> 172.16.139.255 = 1,024 hosts
#     # 172.16.140.0/22: 172.16.140.0 -> 172.16.143.255 = 1,024 hosts
#     private_subnets  = ["172.16.132.0/22", "172.16.136.0/22", "172.16.140.0/22"]
#     # 172.16.131.0/26: 	172.16.131.0 -> 172.16.131.63 = 64 hosts
#     database_subnets = ["172.16.131.0/26", "172.16.131.64/26", "172.16.131.128/26"]
#     # public_subnets   = ["172.16.128.0/24", "172.16.129.0/24", "172.16.130.0/24"]

#     create_igw                         = false
#     create_database_subnet_route_table = true
#     default_route_table_propagation    = true
#     default_route_table_association    = true
#     enable_nat_gateway                 = false
#     single_nat_gateway                 = false
#     one_nat_gateway_per_az             = false
#     enable_vpn_gateway                 = false
#     # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
#     enable_flow_log                                 = false
#     create_flow_log_cloudwatch_log_group            = false
#     create_flow_log_cloudwatch_iam_role             = false
#     flow_log_max_aggregation_interval               = 60
#     flow_log_cloudwatch_log_group_retention_in_days = 30
#     map_public_ip_on_launch                         = false
#     enable_dns_hostnames                            = true
#     enable_dns_support                              = true
#     private_subnet_tags = {
#       "kubernetes.io/role/internal-elb" = 1
#       "karpenter.sh/discovery"          = "True"
#     }
#     create_vpc_attachment                           = true
#     network_assume_role                             = local.common_vars.network_account_assume_role
#     transit_gateway_id                              = local.common_vars.tgw_id
#     enable_transit_route_for_database_subnet        = true
#     tgw_destination_cidr_blocks_of_database_subnets = ["172.16.0.0/12"]
#   }
# )
