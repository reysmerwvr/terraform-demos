resource "aws_security_group" "puppet-master-instance" {
  vpc_id      = "${aws_vpc.main.id}"
  name        = "puppet-master-instance"
  description = "security group that allows ssh, agents will talk to the master and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8140
    to_port     = 8140
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "puppet-master-instance"
  }
}
