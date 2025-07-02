terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"
}

module "ecr" {
  source = "./modules/ecr"
}

module "rds" {
  source             = "./modules/rds"
  private_subnet_ids = module.network.private_subnet_ids
  db_sg_id           = module.ecs.security_group_id
}

module "ecs" {
  source       = "./modules/ecs"
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.private_subnet_ids
  alb_subnet_ids = module.network.public_subnet_ids
  ecr_repo_url = module.ecr.repository_url
  rds_endpoint = module.rds.endpoint
}

module "s3" {
  source = "./modules/s3"
}

module "cloudfront" {
  source                = "./modules/cloudfront"
  s3_bucket_domain_name = module.s3.bucket_domain_name
}

module "eventbridge" {
  source = "./modules/eventbridge"
}

module "lambda" {
  source              = "./modules/lambda"
  eventbridge_bus_arn = module.eventbridge.bus_arn
  s3_bucket_id        = module.s3.bucket_id
  s3_bucket_arn       = module.s3.bucket_arn
}

module "sqs" {
  source = "./modules/sqs"
}

module "sns" {
  source = "./modules/sns"
}

module "cloudwatch" {
  source               = "./modules/cloudwatch"
  ecs_cluster_name     = module.ecs.cluster_name
  lambda_function_name = module.lambda.function_name
} 