# terraform {
#   source = "git::https://github.com/GalaxyFinX/aws-vpc.git?ref=v1.4.4"
#   extra_arguments "custom_vars" {
#     commands = [
#       "apply",
#       "run-all apply",
#       "destroy",
#       "run-all destroy",
#       "plan",
#       "run-all plan",
#       "output",
#       "run-all output",
#     ]
#   }
# }

# locals {
#   # Automatically load input variables
#   common_vars = read_terragrunt_config(find_in_parent_folders("common_vars.hcl"))
# }

# # Include all settings from the root terraform.tfvars file
# include {
#   path = find_in_parent_folders()
# }

# # ---------------------------------------------------------------------------------------------------------------------
# # MODULE PARAMETERS
# # These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# # ---------------------------------------------------------------------------------------------------------------------
# inputs = merge(
#   local.common_vars.inputs,
#   {
#     vpc_name         = local.common_vars.inputs.application
#     cidr             = "172.17.16.0/20"
#     private_subnets  = ["172.17.16.0/22", "172.17.20.0/22", "172.17.24.0/22"]
#     database_subnets = ["172.17.31.0/26", "172.17.31.64/26", "172.17.31.128/26"]
#     #    public_subnets   = ["172.17.28.0/24", "172.17.29.0/24", "172.17.30.0/24"]

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
#     create_flow_log_cloudwatch_log_group            = true
#     create_flow_log_cloudwatch_iam_role             = true
#     flow_log_max_aggregation_interval               = 60
#     flow_log_cloudwatch_log_group_retention_in_days = 30
#     map_public_ip_on_launch                         = false
#     enable_dns_hostnames                            = true
#     enable_dns_support                              = true
#     default_route_table_association                 = true
#     default_route_table_propagation                 = true
#     private_subnet_tags = {
#       "kubernetes.io/role/internal-elb" = 1
#       "karpenter.sh/discovery"          = "True"
#     }
#     create_vpc_attachment                           = true
#     network_assume_role                             = local.common_vars.inputs.network_account_assume_role
#     transit_gateway_id                              = local.common_vars.inputs.tgw_id
#     enable_transit_route_for_database_subnet        = true
#     tgw_destination_cidr_blocks_of_database_subnets = ["172.16.0.0/12"]
#   }
# )
