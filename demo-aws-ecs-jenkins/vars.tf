variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-084f07d75acedcefa"
    us-west-2 = "ami-0ab0050d945a2d795"
    us-west-1 = "ami-056e733017f14ab33"
  }
}

# Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0ff8a91507f77f867"
    us-west-2 = "ami-a0cfeed8"
    us-west-1 = "ami-0bdb828fd58c52235"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "JENKINS_VERSION" {
  default = "2.190.1"
}

variable "TERRAFORM_VERSION" {
  default = "0.12.9"
}

variable "PACKER_VERSION" {
  default = "0.12.9"
}

