resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.medium"
  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"
  # the security group
  vpc_security_group_ids = ["${aws_security_group.puppet-server.id}"]
  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  user_data = "${file("script.sh")}"
  tags = {
    Name = "rvalle"
  }
}
output "ip" {
  value = "${aws_instance.example.public_ip}"
}
