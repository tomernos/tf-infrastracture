output "rabbitmq_broker_id" {
  description = "The ID of the RabbitMQ broker"
  value       = module.rabbitmq_cluster.broker_id
}

output "rabbitmq_broker_arn" {
  description = "The ARN of the RabbitMQ broker"
  value       = module.rabbitmq_cluster.broker_arn
}

output "rabbitmq_broker_endpoints" {
  description = "The endpoints of the RabbitMQ broker"
  value       = module.rabbitmq_cluster.broker_endpoints
}