output "ec2-public_ip" {
    value = aws_instance.foo.public_ip
  
}