module "iam_account" {
  # source  = "../modules/terraform-aws-iam/modules/iam-account"
  source = "terraform-aws-modules/iam/aws//modules/iam-account"
  version = "v5.3.3"

  account_alias = var.iam_user_for_cluster

  minimum_password_length = 37
  require_numbers         = false

}

# https://github.com/terraform-aws-modules/terraform-aws-iam 