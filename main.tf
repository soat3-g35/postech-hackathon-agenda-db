
provider "aws" {
  region = var.region
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["postech-vpc"]
  }
}

resource "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["postech-vpc"]
  }
}

resource "aws_db_instance" "paciente" {
  identifier          = "paciente"
  instance_class      = "db.t3.micro"
  allocated_storage   = 5
  engine              = "postgres"
  engine_version      = "14.11"
  username            = "postgres"
  password            = "postgres"
  publicly_accessible = true
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.selected.id]

  #db_name = "paciente"

  tags = {
    Name = "PacientePostgresDB"
  }
}
