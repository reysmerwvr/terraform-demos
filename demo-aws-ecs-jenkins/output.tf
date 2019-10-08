output "elb" {
  value = aws_elb.nodejsapp-elb.dns_name
}

output "jenkins" {
  value = aws_instance.jenkins-instance.public_ip
}

output "nodejsapp-repository-URL" {
  value = aws_ecr_repository.nodejsapp.repository_url
}

