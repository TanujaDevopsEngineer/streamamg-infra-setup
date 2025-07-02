variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "ecr_repo_url" {
  type = string
}

variable "rds_endpoint" {
  type = string
}

variable "alb_subnet_ids" {
  type = list(string)
  description = "List of public subnet IDs for the ALB."
} 