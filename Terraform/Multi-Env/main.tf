terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Create EC2 instances for each environment
resource "aws_instance" "servers" {
  for_each = {
    for env, config in var.environment_config : env => config
  }

  # Create 100 servers per environment
  count = each.value.server_count

  ami           = var.ami_id
  instance_type = each.value.instance_type
  
  # Associate security groups if provided
  vpc_security_group_ids = var.vpc_security_group_ids != [""] ? var.vpc_security_group_ids : null

  root_block_device {
    volume_type           = "gp3"
    volume_size           = each.value.environment == "prod" ? 50 : 20
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.tag_prefix}-${each.value.environment}-${count.index + 1}"
    Environment = each.value.environment
    ManagedBy   = "Terraform"
    CreatedAt   = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }
}
