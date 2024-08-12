variable "sg_name" {
  description = "The name of the security group"
  type        = string
}

variable "sg_description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "Map of ingress rules to create"
  type        = map(object({
    cidr_ipv4 = list(string)
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

variable "egress_rules" {
  description = "Map of egress rules to create"
  type        = map(object({
    cidr_ipv4 = list(string)
    from_port = number
    to_port   = number
    protocol  = string
  }))
}