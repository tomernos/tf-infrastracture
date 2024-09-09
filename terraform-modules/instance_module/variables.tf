variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = any
  default = {}
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
}

variable "environment" {
  description = "The environment tag for the EC2 instance"
  type        = string
  default     = "Test"
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance into"
  type        = string
}


variable "target_group_arn" {
  description = "ARN of the target group to associate the instance with"
  type        = string
  default     = ""
}

variable "target_group_attachments" {
  description = "Map of target group names to attach the instance to"
  type        = map(string)
  default     = {}
}