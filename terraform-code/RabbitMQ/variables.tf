variable "rabbitmq" {
  description = "RabbitMQ configuration"
  type = object({
    aws_region     = string
    vpc_name       = string
    security_group = object({
      name = string
    })
    broker = object({
      name            = string
      engine_type     = string
      engine_version  = string
      instance_type   = string
      deployment_mode = string
      subnet_names    = list(string)
    })
    manager-usr = object({
      username = string
      password = string
    })
    tags           = map(string)
  })
}

#### locals variables #####

variable "environment" {
  type        = any
  default = {}
}