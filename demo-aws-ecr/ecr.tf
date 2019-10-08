resource "aws_ecr_repository" "nodejsapp" {
  name = "nodejsapp"
  tags = {
    Name = "rvalle"
  }
}

