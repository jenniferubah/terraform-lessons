provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  instance_class      = "db.t2.micro"
  identifier_prefix   = "terraform-example-db"
  engine              = "mysql"
  allocated_storage   = 10
  skip_final_snapshot = true
#   engine_version = "8.0"
  db_name             = "my_database"


  username = "rdsdb"
  password = "rdspassword"
#   username = var.db_username
#   password = var.db_password
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