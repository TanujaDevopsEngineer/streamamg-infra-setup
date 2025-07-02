output "vpc_id" {
  value = module.network.vpc_id
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "cloudfront_domain_name" {
  value = module.cloudfront.domain_name
}

output "ecs_security_group_id" {
  value = module.ecs.security_group_id
} 