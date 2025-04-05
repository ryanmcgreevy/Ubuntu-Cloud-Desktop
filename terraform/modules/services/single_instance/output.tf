output "instance_dns_name" {
  value       = aws_instance.single[*].public_dns
  description = "The domain name of the single instance"
}