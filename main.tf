# Provider configuration
provider "aws" {
  region = var.aws_region
}

# Security Group Module
module "security_group" {
  source = "./security_groups_module"
  
  for_each = var.SecurityGroups

  sg_name        = each.value.name
  sg_description = "Security group for ${each.value.name}"
  vpc_id         = each.value.vpcid
  
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
}

# EC2 Instances Module
module "ec2_instances" {
  source = "./instance_module"

  for_each = var.ec2_config

  ami_id            = each.value.ami_id
  instance_type     = each.value.instance_type
  availability_zone = each.value.availability_zone
  instance_name     = each.value.name
  environment       = each.value.environment
  security_group_ids = each.key == "vm1" ? [module.security_group["sg1"].security_group_id] : []
}