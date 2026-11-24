
# VPC
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
}

# Security
module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

# ECR
module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
}

# Secrets Manager
module "secrets" {
  source = "../../modules/secrets"

  project_name = var.project_name
}

# IAM
module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  secret_arn   = module.secrets.secret_arn
}

# ALB
module "alb" {
  source = "../../modules/alb"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  certificate_arn       = var.certificate_arn
}

# ECS
module "ecs" {
  source = "../../modules/ecs"

  project_name       = var.project_name
  aws_region         = var.aws_region
  ecr_repository_url = module.ecr.repository_url

  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn

  secret_arn = module.secrets.secret_arn

  log_group_name = module.logging.log_group_name

  private_subnet_ids    = module.vpc.private_subnet_ids
  ecs_security_group_id = module.security.ecs_security_group_id
  target_group_arn      = module.alb.target_group_arn

  desired_count = 2

  depends_on = [
    module.alb,
    module.logging
  ]
}

# Monitoring
module "monitoring" {
  source = "../../modules/monitoring"

  project_name     = var.project_name
  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  alb_arn_suffix   = module.alb.alb_arn_suffix
}

module "logging" {
  source = "../../modules/logging"

  project_name = var.project_name
}