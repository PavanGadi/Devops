output "servers_by_environment" {
  description = "Overview of servers created in each environment"
  value = {
    for env, config in var.environment_config : env => {
      instance_type = config.instance_type
      count         = config.server_count
      region        = var.aws_region
    }
  }
}

output "dev_instances" {
  description = "Dev environment EC2 instance IDs"
  value       = try([for instance in aws_instance.servers["dev"] : instance.id], [])
}

output "test_instances" {
  description = "Test environment EC2 instance IDs"
  value       = try([for instance in aws_instance.servers["test"] : instance.id], [])
}

output "prod_instances" {
  description = "Prod environment EC2 instance IDs"
  value       = try([for instance in aws_instance.servers["prod"] : instance.id], [])
}

output "dev_private_ips" {
  description = "Dev environment private IP addresses"
  value       = try([for instance in aws_instance.servers["dev"] : instance.private_ip], [])
}

output "test_private_ips" {
  description = "Test environment private IP addresses"
  value       = try([for instance in aws_instance.servers["test"] : instance.private_ip], [])
}

output "prod_private_ips" {
  description = "Prod environment private IP addresses"
  value       = try([for instance in aws_instance.servers["prod"] : instance.private_ip], [])
}

output "all_servers_summary" {
  description = "Summary of all deployed servers"
  value = {
    total_servers = sum([for config in var.environment_config : config.server_count])
    environments = {
      for env, config in var.environment_config : env => {
        instance_type = config.instance_type
        count         = config.server_count
        instances     = try([for instance in aws_instance.servers[env] : instance.id], [])
      }
    }
  }
}
