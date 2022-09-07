provider "aws" {
    region = var.region

}

terraform {

    # terraform > version 1.0 how to specify required provider versions
    # We strongly advocate that you pin your versions in production
    # code. For example, required_version = "1.1.2" pins to the specified version.
    # In the required_providers block, you specify like version = "2.11.0"
    # You can also specify ~> to let terraform pick the most compatible version for
    # your code set. We do not advocate using ~>
    # Since this is not production code, we specify >= for required_version and version
    # We also specify this for each provider.

    # Notice how we place required_version 1st, and outside of the required_providers
    # block. The terraform documentation leaves a lot to be desired, so please be
    # mindful to follow the practice demonstrated below.


    required_version = ">= 1.2.5"

    required_providers {

        # aws = {
        #   source  = "hashicorp/aws"
        #   version = ">= 4.18.0"
        # }

        cloudinit = {
          source  = "hashicorp/cloudinit"
          version = ">= 2.2.0"
        }

        kubernetes = {
          source  = "hashicorp/kubernetes"
          version = ">= 2.11.0"
        }

        local = {
          source  = "hashicorp/local"
          version = ">= 2.2.3"
        }

        tls = {
          source  = "hashicorp/tls"
          version = ">= 3.4.0"
        }

    }

# ----------
# remove when you push the code to the repo, always use a single TF state file
# when applying changes to production.
# ----------

    backend "s3" {
        bucket = "kentcloudazdevops"
        key = "tfstate"
        region = "us-east-1"
    }

}


# https://www.terraform.io/language/settings/backends/s3