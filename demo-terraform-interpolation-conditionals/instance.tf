data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "example" {
  ami           = "${data.aws_ami.amzn2.id}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${var.ENV == "prod" ? module.vpc-prod.public_subnets[0] : module.vpc-dev.public_subnets[0]}"

  # the security group
  vpc_security_group_ids = ["${var.ENV == "prod" ? aws_security_group.allow-ssh-prod.id : aws_security_group.allow-ssh-dev.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}
