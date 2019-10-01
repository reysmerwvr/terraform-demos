variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-00b882ac5193044e4"
    us-west-2 = "ami-000b133338f7f4255"
    us-west-1 = "ami-0f62aafc6efe8fd7b"
  }
}
