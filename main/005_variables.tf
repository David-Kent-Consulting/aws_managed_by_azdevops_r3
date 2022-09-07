# -------------------------------------
# global variables
# -------------------------------------

variable "region" {
    default         = "us-east-1"
    type            = string
    description     = "Region of the VPC"
}

variable "availability_zones" {
    default         = ["us-east-1c", "us-east-1d", "us-east-1f"] # you may need to select different AZs based on available capacity
    type            = list
    description     = "The AZs where we will place subnetworks"
}

variable "project_name" {
    default         = "kentuniversity"
    type            = string
    description     = "This is the root name that will be applied to all resources"
}

variable "platform_type" {
    default         = "dev - Managed by Terraform"
    type            = string
    description = "set to dev, sandbox, tst, qa, or prod based on platform this code is being pushed to"
}

# -------------------------------------
# network variables
# -------------------------------------

variable "vpc_cidr" {
    default         = "10.0.0.0/16"
    type            = string
    description     = "CIDR for VPN in this project"
}

variable "priv_subnets" {
    default         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    type            = list
    description     = "The private subnetworks to build within this VPC"
}

variable "pub_subnets" {
    default         = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    type            = list
    description     = "The public subnetworks"
}

variable "enable_nat_gateway" {
    default         = true
    type            = bool
    description = "set to true or false to enable or disable NAT service for subnetwork"
}

variable "enable_vpn_gateway" {
    default         = false
    type            = bool
    description = "set to true or false to enable or disable VPN service for subnetwork"
}

# ----------
# user data
# ----------
variable "iam_user_for_cluster" {
    default         = "demouser2"
    type            = string
    description     = "This is the test user for this test cluster"
}