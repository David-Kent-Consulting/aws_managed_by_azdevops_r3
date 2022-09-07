module "vpc" {
/*
  Do not add the modules directory to the git repo. Comment out references to
  the local copy and reference the AWSD GIT source when applying this code to
  the master branch.
*/
    # source = "../modules/terraform-aws-vpc/"
    source = "terraform-aws-modules/vpc/aws"
    version = "v3.14.4"


    name            = "${var.project_name}-vpc"
    cidr            = var.vpc_cidr

    azs             = var.availability_zones
    private_subnets = var.priv_subnets
    public_subnets  = var.pub_subnets

    enable_nat_gateway = var.enable_nat_gateway
    enable_vpn_gateway = var.enable_vpn_gateway

    tags = {
      Project   = var.project_name
      Terraform = "true"
      Environment = var.platform_type
    }
}

# https://github.com/terraform-aws-modules/terraform-aws-vpc