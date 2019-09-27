terraform {
  backend "s3" {
    bucket = "terraform-state-demo-app"
    key = "terraform/demo4"
  }
}