resource "random_password" "db" {
  length  = 16
  special = true
}

resource "aws_db_subnet_group" "main" {
  subnet_ids = var.private_subnet_ids
  name       = "main-db-subnet-group"
}

resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "17.5"
  instance_class       = "db.t3.micro"
  db_name              = "streamamg"
  username             = "streamamgadmin"
  password             = random_password.db.result
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_sg_id]
  skip_final_snapshot  = true
}

output "endpoint" {
  value = aws_db_instance.main.endpoint
} 