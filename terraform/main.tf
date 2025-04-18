locals {
  prefix = "myapp"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_ecr_repository" "ecr" {
  name         = "${var.env}-ecr"
  force_delete = true

  lifecycle {
    ignore_changes = [name]
  }
}

module "iam_task_role" {
  source = "./modules/iam"
  env    = var.env
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "${local.prefix}-${var.env}-ecs"

  create_cloudwatch_log_group = false

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    flask-service = {
      cpu    = 512
      memory = 1024
      task_role_arn = module.iam_task_role.task_role_arn

      container_definitions = {
        flask-container = {
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.env}-ecr:latest"
          port_mappings = [{
            containerPort = 8080
            protocol      = "tcp"
          }]
        }
      }

      assign_public_ip     = true
      subnet_ids           = var.public_subnet_ids
      security_group_ids   = var.security_group_ids
    }
  }
}
