# Multi-Environment AWS EC2 Deployment

This Terraform configuration creates 100 EC2 servers in each of three environments: **dev**, **test**, and **prod**.

## Architecture Overview

### Instance Types by Environment

| Environment | Instance Type | Count | Use Case | Volume Size |
|-------------|---------------|-------|----------|-------------|
| **dev**     | t3.micro      | 100   | Development & Testing | 20 GB |
| **test**    | t3.small      | 100   | QA & Staging | 20 GB |
| **prod**    | m5.large      | 100   | Production | 50 GB |

### Total Deployment
- **300 total EC2 instances** across all environments
- All instances use AWS EC2 with public/private networking
- Each instance is tagged with environment and sequential naming

## Files Description

- **main.tf** - Core resource definitions (EC2 instances with nested for_each loops)
- **variables.tf** - Variable definitions for configuration
- **provider.tf** - AWS provider configuration
- **output.tf** - Output values for instance IDs and IP addresses

## Prerequisites

1. AWS Account with appropriate IAM permissions
2. Terraform >= 1.0 installed
3. AWS CLI configured with credentials
4. (Optional) SSH key pair for EC2 access

## Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Review Plan

```bash
terraform plan
```

This will show you all 300 instances that will be created.

### 3. Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted to create all instances.

### 4. Get Instance Information

After successful deployment:

```bash
terraform output all_servers_summary
```

To get specific environment details:

```bash
terraform output dev_instances
terraform output test_instances
terraform output prod_instances
```

## Customization

### Change Instance Counts

Edit `variables.tf` and modify the `server_count` value:

```hcl
environment_config = {
  dev = {
    instance_type = "t3.micro"
    server_count  = 50    # Changed from 100
    environment   = "dev"
  }
  ...
}
```

### Change Instance Types

Update the `instance_type` in `variables.tf`:

```hcl
dev = {
  instance_type = "t3.small"     # Changed from t3.micro
  ...
}
```

### Change AWS Region

Update the `aws_region` variable:

```bash
terraform apply -var="aws_region=us-west-2"
```

Or set in `terraform.tfvars`:

```hcl
aws_region = "eu-west-1"
```

## Security Considerations

⚠️ **Important**: Before deploying to production:

1. Configure security groups explicitly
2. Use VPC endpoints for private instances
3. Enable VPC Flow Logs for monitoring
4. Implement AWS systems manager for access
5. Enable CloudWatch monitoring and alarms
6. Use AWS Systems Manager Session Manager instead of SSH

## Cleanup

To destroy all instances:

```bash
terraform destroy
```

## Instance Naming Convention

Instances are automatically named using the pattern:

```
aws-server-{environment}-{number}
```

Examples:
- `aws-server-dev-1` to `aws-server-dev-100`
- `aws-server-test-1` to `aws-server-test-100`
- `aws-server-prod-1` to `aws-server-prod-100`

## Estimated Costs

Running costs vary by region and usage. Estimate using AWS Pricing Calculator with:
- 100 x t3.micro
- 100 x t3.small
- 100 x m5.large

## Troubleshooting

### Insufficient Capacity

If Terraform fails with "InsufficientInstanceCapacity":
- Change availability zone
- Reduce instance count temporarily
- Try different instance type

### Permission Errors

Ensure IAM user/role has permissions:
- `ec2:RunInstances`
- `ec2:CreateTags`
- `ec2:DescribeInstances`

### AMI Not Found

Update `ami_id` in `variables.tf` for your region:
```bash
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --region us-east-1
```

## Support

For issues or questions, check:
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
