resource "aws_mq_broker" "rabbitmq_cluster" {
  broker_name           = var.broker_name
  engine_type           = var.engine_type
  engine_version        = var.engine_version
  host_instance_type    = var.host_instance_type
  deployment_mode       = var.deployment_mode  # Multi-node cluster
  
  #security_groups       = var.security_group_ids
  publicly_accessible   = true
  auto_minor_version_upgrade = true

  user {
    username = var.username
    password = var.password
  }

  #subnet_ids = var.subnet_ids 

  tags = merge(var.tags,{
    Name = var.broker_name
  })
}

output "broker_id" {
  description = "The ID of the RabbitMQ broker"
  value       = aws_mq_broker.rabbitmq_cluster.id
}

output "broker_arn" {
  description = "The ARN of the RabbitMQ broker"
  value       = aws_mq_broker.rabbitmq_cluster.arn
}

output "broker_endpoints" {
  description = "The endpoints of the RabbitMQ broker"
  value       = aws_mq_broker.rabbitmq_cluster.instances[*].endpoints
}