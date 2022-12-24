output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.dev-pro.id
} 


output "vpc_ARN" {
  description = "arn of project VPC"
  value       = aws_vpc.dev-pro.arn
}