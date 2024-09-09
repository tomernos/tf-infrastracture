####################################                        
#      variables for provider      #
####################################

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

################################                        
#      variables for vpcs      #
################################

variable "environment" {
  type        = any
  default = {}
}

variable "vpcs" {
  type        = any
  default = {}
}

################################                        
#  variables for vpcstags      #
################################



###############################                         
#      variables for pus      #
###############################

variable "public_subnets" {
  description = "A map of public subnets with their properties"
  type = any
}

###############################                         
#      variables for prs      #
###############################

variable "private_subnets" {
  description = "A map of private subnets with their properties"
  type = any
}

##############################                        
#      variables for rt      #
##############################

variable "route_tables" {
  description = "Configuration for route tables"
  type = any
}

###########################                         
#   variables for Ec2     #
###########################

variable "ec2_config" {
  description = "Configuration for EC2 instances"
  type = any
}

##########################################                         
#      variables for SecurityGroups      #
##########################################

variable "SecurityGroups" {
  description = "Configuration for security groups, including ingress and egress rules"
  type = any
}
##############################################                        
#      variables for auto load balancer      #
##############################################

variable "alb_config" {
  description = "Configuration for the ALB"
  type = any
}

##############################################                        
#      variables for auto scaling group      #
##############################################

variable "asg_config" {
  description = "Configuration for Auto Scaling Groups"
  type = any  
}


##############################################                        
#      variables for auto load balancer      #
##############################################
/*
variable "existing_instance_config" {
  description = "Configuration for the existing EC2 instance"
  type = object({
    instance_id         = string
    ami_id              = string
    instance_type       = string
    key_name            = string
    security_group_name = string
    subnet_name         = string
  })
}*/