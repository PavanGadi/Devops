variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment_config" {
  description = "Configuration for each environment"
  type = map(object({
    instance_type = string
    server_count  = number
    environment   = string
  }))
  default = {
    dev = {
      instance_type = "t3.micro"      # Small, cost-effective for development
      server_count  = 100
      environment   = "dev"
    }
    test = {
      instance_type = "t3.small"      # Medium, better performance for testing
      server_count  = 100
      environment   = "test"
    }
    prod = {
      instance_type = "m5.large"      # Larger, production-grade performance
      server_count  = 100
      environment   = "prod"
    }
  }
}

variable "ami_id" {
  description = "AMI ID for EC2 instances (Amazon Linux 2)"
  type        = string
  default     = "ami-09c813fb71547fc4f"
}

variable "vpc_security_group_ids" {
  description = "Security group IDs for EC2 instances"
  type        = list(string)
  default     = [""]
}

variable "tag_prefix" {
  description = "Prefix for server names"
  type        = string
  default     = "aws-server"
}
