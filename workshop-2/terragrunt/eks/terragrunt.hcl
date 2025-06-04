
terraform {
  source = "../../../terraform-modules/aws-eks"
}

locals {
  # Automatically load input variables
  common_vars  = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  cluster_name = "${local.common_vars.application}"
}

include {
  path   = find_in_parent_folders("global.hcl")
  expose = true
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id          = "vpc-1234566789"
    private_subnets = ["subnet-08c5671f12345678"]
    public_subnets  = ["subnet-08c5671f12345678"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
    profile                  = local.common_vars.profile
    cluster_name             = local.cluster_name
    cluster_version          = "1.31"
    
    # EKS Addons
    cluster_addons = {
      # coredns                = {}
      eks-pod-identity-agent = {}
      kube-proxy             = {}
      vpc-cni                = {}
    }

    vpc_id                   = dependency.vpc.outputs.vpc_id
    subnet_ids               = dependency.vpc.outputs.private_subnets

    enable_cluster_creator_admin_permissions = true
    cluster_endpoint_private_access = true # default is true
    cluster_endpoint_public_access  = true # default is false

    cluster_enabled_log_types = []
    cluster_encryption_config = {
      "resources": [
        "secrets"
      ]
    }

    eks_managed_node_group_defaults = {
      instance_types = ["t3.medium", "t3a.medium", "t2.medium", "t4g.medium"]
      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
      ]
    }

    self_managed_node_groups = {
      infra-node = {
        ami_type       = "BOTTLEROCKET_x86_64"
        instance_types = ["t3.medium", "t3a.medium", "t2.medium", "t4g.medium"]

        # use module user data template to boostrap
        enable_bootstrap_user_data = true
        # this will get added to the template
        bootstrap_extra_args = <<-EOT
        # extra args added
        [settings.kernel]
        lockdown = "integrity"
        EOT
        desired_size         = 0
        min_size             = 0
        max_size             = 5
        capacity_type        = "ON_DEMAND"
        force_update_version = true
        update_config = {
          max_unavailable_percentage = 50 # or set `max_unavailable`
        }

        block_device_mappings = {
          root = {
            device_name = "/dev/xvda"
            ebs = {
              volume_size           = 5
              delete_on_termination = true
              encrypted             = true
            }
          }
          containers = {
            device_name = "/dev/xvdb"
            ebs = {
              volume_size           = 30
              delete_on_termination = true
              encrypted             = true
            }
          }
        }

        labels = {
          environment                      = "shared-services"
          type                             = "infra"
          "eks.leesantee.org/environment"  = "nonprod-shared-services"
          "eks.leesantee.org/nodegroup"    = "shared-services"
          "eks.leesantee.org/type"         = "infra"
           "karpenter.sh/controller"       = "true"
        }
      }

    }
    node_security_group_tags = {
      "karpenter.sh/discovery" = "${local.common_vars.master_prefix}-${local.cluster_name}" //Add tag to nodegroup sg
    }
    manage_aws_auth_configmap = true
    aws_auth_accounts         = ["${local.common_vars.account_id}"]
    aws_auth_roles = [
      {
        rolearn  = "arn:aws:iam::604928740921:role/AWSReservedSSO_AWSAdministratorAccess_8a9aa29fcca60805"
        username = "AWSReservedSSO_AWSAdministratorAccess_8a9aa29fcca60805"
        groups   = ["system:masters"]
      }
    ]

    create_cloudwatch_log_group=false   
}