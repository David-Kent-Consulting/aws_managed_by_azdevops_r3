module "eks" {
/*
  Do not add the modules directory to the git repo. Comment out references to
  the local copy and reference the AWSD GIT source when applying this code to
  the master branch.
*/
  # source = "../modules/terraform-aws-eks"
  source = "terraform-aws-modules/eks/aws"
  version = "v18.29.0"


  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.22"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  
  # this is an example of how we get data created by a module, see 999_output.tf
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # must use private subnet in order for fargate to work

  # Self Managed Node Group(s)
  self_managed_node_group_defaults = {
    instance_type                          = "m6i.large"
    update_launch_template_default_version = true
    # The following is a default role per https://aws.amazon.com/blogs/mt/applying-managed-instance-policy-best-practices/
    # This is OK to use for demo purposes, you should define your own in the real world.
    iam_role_additional_policies = [
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
  }

  self_managed_node_groups = {
    one = {
      name         = "mixed-1"
      max_size     = 5
      desired_size = 2

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = 2
          on_demand_percentage_above_base_capacity = 10
          # spot_allocation_strategy                 = "lowest-price" # lowest priority for allocation
          # spot_allocation_strategy                 = "capacity-optimized" # medium priority for allocation
          spot_allocation_strategy                  = "capacity-optimized-prioritized" # highest priority for allocation
        }

        override = [
          {
            instance_type     = "m5.large"
            weighted_capacity = "1"
          },
          {
            instance_type     = "m6i.large"
            weighted_capacity = "2"
          },
        ]
      }
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    # This disk is undersized for most situations. OK for the demo.
    disk_size      = 50
    # Not a good idea to shrink below the following, k8s needs decent performance.
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    # we would never roll with less than 2 nodes per node group, so take this
    # section for what it is worth.
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "ON_DEMAND"
    }
  }

# aws-auth configmap
  # the user for the demo is created with 020_iam_users.tf, this could just
  # as easily be getting the user list. If a list, then the following code
  # would have to be modified accordingly, but you would have to inspect the
  # module source on GIT to make sure you get it right.
  aws_auth_roles = [
    {
      rolearn  = module.iam_account.caller_identity_arn
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = module.iam_account.caller_identity_arn
      username = "user1"
      groups   = ["system:masters"]
    }
  ]

  # Fargate Profile(s)
  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "default"
        }
      ]
    }
  }

  tags = {
    Project   = var.project_name
    Environment = var.platform_type
    Terraform   = "true"
  }
}

# https://github.com/terraform-aws-modules/terraform-aws-eks 