provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-example-db"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "my_database"

#   username = "dbuser"
#   password = "dbpassword"
    username = var.db_username
    password = var.db_password
}

terraform {
  backend "s3" {
    bucket = "jen-terraform-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}