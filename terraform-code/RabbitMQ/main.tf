provider "aws" {
  region = var.rabbitmq.aws_region
}

terraform {
  backend "s3" {}
}

locals {
  tags = { environment = var.environment}
}

data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.rabbitmq.vpc_name]
  }
}

data "aws_subnet" "selected_subnets" {
  for_each = toset(var.rabbitmq.broker.subnet_names)
  
  vpc_id = data.aws_vpc.existing_vpc.id
  filter {
    name   = "tag:Name"
    values = [each.key]
  }
}

data "aws_security_group" "rabbitmq_sg" {
  vpc_id = data.aws_vpc.existing_vpc.id
  
  filter {
    name   = "tag:Name"
    values = [var.rabbitmq.security_group.name]
  }
}


module "rabbitmq_cluster" {
  source = "../../terraform-modules/rabbitmq-module"

  broker_name           = var.rabbitmq.broker.name
  engine_type           = var.rabbitmq.broker.engine_type
  engine_version        = var.rabbitmq.broker.engine_version
  host_instance_type    = var.rabbitmq.broker.instance_type
  deployment_mode       = var.rabbitmq.broker.deployment_mode
  
  security_group_ids    = [data.aws_security_group.rabbitmq_sg.id]
  subnet_ids            = [for subnet in data.aws_subnet.selected_subnets : subnet.id]

  username     = var.rabbitmq.manager-usr.username
  password     = var.rabbitmq.manager-usr.password

  tags = merge(local.tags ,lookup(var.rabbitmq, "tags",{}))
}