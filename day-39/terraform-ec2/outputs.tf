output "instance_id" {
  value = aws_instance.docker_ec2.id
}

output "public_ip" {
  value = aws_instance.docker_ec2.public_ip
}

output "application_url" {
  value = "http://${aws_instance.docker_ec2.public_ip}:5000"
}
