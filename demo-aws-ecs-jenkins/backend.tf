terraform {
  backend "s3" {
    bucket = "terraform-state-demo-aws-ecs"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
