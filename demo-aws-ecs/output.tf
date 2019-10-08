output "elb" {
  value = aws_elb.nodejsapp-elb.dns_name
}

