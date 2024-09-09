# Provider configuration

provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
  }
}

locals {
  tags = { environment = var.environment}
}

module "vpc" {
  source     = "../../terraform-modules/vpc_module"
  for_each = var.vpcs
  cidr_block = each.value.cidr_block
  vpc_name   = each.key
  
  tags = merge(local.tags ,lookup(each.value, "tags",{}))

}

module "subnets" {
  source   = "../../terraform-modules/subnet_module"
  for_each = merge(var.public_subnets, var.private_subnets)

  vpc_id                  = module.vpc[each.value.vpc_name].vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = contains(keys(var.public_subnets), each.key)
  subnet_name             = each.key
}

module "route_tables" {
  source   = "../../terraform-modules/route_table_module"
  for_each = var.route_tables

  vpc_id           = module.vpc[each.value.vpc_name].vpc_id
  route_table_name = each.value.name
  routes           = each.value.routes
  subnet_ids           = {for subnet_name in each.value.subnet_associations: subnet_name => module.subnets[subnet_name].subnet_id}
  internet_gateway_id = module.vpc[each.value.vpc_name].internet_gateway_id

  depends_on = [module.subnets]
}

/*module "auto_load_balancer" {
  source = "../../terraform-modules/alb_module"
  for_each = var.alb_config

  alb_name           = each.value.alb_name
  vpc_id             = module.vpc[each.value.vpc_name].vpc_id 
  subnet_ids         = [for subnet_name in each.value.subnet_associations:  module.subnets[subnet_name].subnet_id]
  security_group_ids = [module.security_group[each.value.security_group_name].security_group_id]
  listeners      = each.value.listeners
  target_group_names  = each.value.target_group_names
  tags = merge(local.tags ,lookup(each.value, "tags",{}))
  #targets         = {for instance_name in each.value.instance_associations: instance_name => module.ec2_instances[instance_name].instance_id}
}*/


/*module "asg" {
  source = "../../terraform-modules/asg_module"
  for_each = var.asg_config

  asg_name           = each.key
  ami_id             = each.value.ami_id
  instance_type      = each.value.instance_type
  security_group_ids = [for sg in each.value.security_group_names : module.security_group[sg].security_group_id]
  subnet_ids         = [for subnet_name in each.value.subnet_names : module.subnets[subnet_name].subnet_id]
  target_group_arns  = flatten([for alb in module.auto_load_balancer : values(alb.target_group_arns_map)])

  min_size         = each.value.min_size
  max_size         = each.value.max_size
  desired_capacity = each.value.desired_capacity
  
}*/


# Security Group Module
module "security_group" {
  source = "../../terraform-modules/security_group_module"
  
  for_each = var.SecurityGroups
  
  sg_name        = each.key
  sg_description = "Security group for ${each.key}"
  vpc_id         = module.vpc[each.value.vpc_name].vpc_id

  
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
}

# EC2 Instances Module
# module "ec2_instances" {
#   source = "../../terraform-modules/instance_module"

#   for_each = var.ec2_config

#   ami_id              = each.value.ami_id
#   instance_type       = each.value.instance_type
#   subnet_id           = module.subnets[each.value.subnet_name].subnet_id
#   instance_name       = each.key
#   tags = merge(local.tags ,lookup(each.value, "tags",{}))
#   security_group_ids  = try([module.security_group[each.value.security_group_name].security_group_id],[])
#   #target_group_attachments =  (each.value.alb_name != "" && length(each.value.target_group_associate) > 0 ? { for tg_name, tg_arn in lookup(module.auto_load_balancer, each.value.alb_name, {target_group_arns_map = {}}).target_group_arns_map : tg_name => tg_arn if contains(each.value.target_group_associate, tg_name) } : {} ) 
#   /*target_group_attachments = {
#     for tg_name in each.value.target_group_associate :
#     tg_name => lookup(module.auto_load_balancer[each.value.alb_name].target_group_arns_map, tg_name, "")*/
# }