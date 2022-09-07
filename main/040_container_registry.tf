resource "aws_ecr_repository" "ecr" {
    name                    = "${var.project_name}-ecr"
    image_tag_mutability    = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }

    tags = {
      Project   = var.project_name
      Terraform = "true"
      Environment = var.platform_type
    }
}