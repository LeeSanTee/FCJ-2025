terraform {
  source = "git::https://${get_env("GITHUB_BOT_USER")}:${get_env("GITHUB_BOT_PRIVATE_TOKEN")}@github.com/LeeSanTee/aws-transit-gateway.git?ref=main"
}

locals {
  # Automatically load input variables
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

# Include all settings from the root terraform.tfvars file
include {
  path = find_in_parent_folders()
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------
inputs = merge(
  local.common_vars.inputs,
  {
    create_transit_gateway         = true
    transit_gateway_name           = "leesantee-network"
    auto_accept_shared_attachments = "disable"
    share_transit_gateway          = false
    ram_principals = []
    transit_gateway_config = {
      integration = {
        create_transit_gateway_route_table = true
        create_transit_gateway_attachment  = false
      },
      internal = {
        create_transit_gateway_route_table = true
        create_transit_gateway_attachment  = false
      },
      egress = {
        create_transit_gateway_route_table = true
        create_transit_gateway_attachment  = false
      },
      ingress = {
        create_transit_gateway_route_table = true
        create_transit_gateway_attachment  = false
      },
    }
  }
)
