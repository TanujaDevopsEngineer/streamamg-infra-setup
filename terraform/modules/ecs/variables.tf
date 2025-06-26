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