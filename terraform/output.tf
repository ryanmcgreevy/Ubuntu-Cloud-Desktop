output "instance_dns_name" {
  value       = module.single_instance.instance_dns_name
  description = "The domain name of the single instance"
}