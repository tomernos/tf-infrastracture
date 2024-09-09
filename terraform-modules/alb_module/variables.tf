variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the ALB will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet names to associate with the route table"
  type        = list(string)
}
variable "tags" {
  description = "tags"
  type        = any
  default = {}
}


variable "security_group_ids" {
  description = "A list of security group IDs to associate with the ALB"
  type        = list(string)
}

variable "listeners" {
  description = "List of listener ports for the ALB"
  type        = any
}

variable "target_group_names" {
  description = "The name of the target group"
  type        = any
}
variable "internal" {
  type        = bool
  default = false
}
variable "load_balancer_type" {
  type        = string
  default = "application"
}

# variable "targets" {
#   description = "A list of instance IDs to register with the target group"
#   type        = map(string)
# }