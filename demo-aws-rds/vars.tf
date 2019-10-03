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
    us-east-1 = "ami-0ff8a91507f77f867"
    us-west-2 = "ami-a0cfeed8"
    us-west-1 = "ami-0bdb828fd58c52235"
  }
}
variable "RDS_PASSWORD" {}
