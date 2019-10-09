resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-demo-aws-ecs"
  acl    = "private"
  #force_destroy = true
  tags = {
    Name = "Terraform state"
  }
}

