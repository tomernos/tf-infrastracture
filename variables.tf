variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

###########################                         
#   variables for Ec2     #
###########################

variable "ec2_config" {
  description = "Configuration for EC2 instances"
  type = map(object({
    ami_id             = string
    instance_type      = string
    availability_zone  = string
    name               = string
    environment        = string
  }))
}

###########################                         
#   variables for SG      #
###########################
variable "SecurityGroups" {
  description = "Configuration for security groups, including ingress and egress rules"
  type = map(object({
    name          = string
    vpcid         = string
    ingress_rules = map(object({
      cidr_ipv4 = list(string)
      from_port  = number
      to_port    = number
      protocol   = string
    }))
    egress_rules = map(object({
      cidr_ipv4 = list(string)
      from_port  = number
      to_port    = number
      protocol   = string
    }))
  }))
}