variable "broker_name" {
  description = "The name of the RabbitMQ broker"
  type        = string
}
variable "engine_type" {
  description = "The name of the RabbitMQ broker"
  type        = string
}
variable "engine_version" {
  description = "The name of the RabbitMQ broker"
  type        = string
}

variable "host_instance_type" {
  description = "The instance type of the broker"
  type        = string
}

variable "username" {
  description = "Admin username for RabbitMQ"
  type        = string
}

variable "password" {
  description = "Admin password for RabbitMQ"
  type        = string
}

variable "security_group_ids" {
  description = "Security group ID for the broker"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Subnets for the RabbitMQ broker, spread across availability zones"
  type        = list(string)
}

variable "deployment_mode" {
  description = "Deployment mode for RabbitMQ (e.g., ACTIVE_STANDBY_MULTI_AZ for cluster)"
  default     = "ACTIVE_STANDBY_MULTI_AZ"
}

variable "tags" {
  description = "tags"
  type        = any
  default = {}
}