# Creating an EC2 Instance

## Objective
This exercise teaches you how to create a basic EC2 instance using Terraform.

## Instructions
1. Set up the AWS provider in `main.tf`.
2. Define an `aws_instance` resource with the specified AMI and instance type.
3. Use the `ami_id` and `instance_type` variables from `variables.tf`.

## Steps
1. Run `terraform init` to initialize the project.
2. Use `terraform plan` to preview the changes.
3. Apply the configuration with `terraform apply`.

## Commands
- `terraform init`
- `terraform plan`
- `terraform apply`

## Expected Result
An EC2 instance will be created in the specified AWS region using the provided AMI and instance type.
