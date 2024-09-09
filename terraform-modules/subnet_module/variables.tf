variable "vpc_id" {
  description = "The VPC ID where subnet will be created"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "The AZ where the subnet will be created"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
  type        = bool
  default     = false
}

variable "subnet_name" {
  description = "Name tag of the subnet"
  type        = string
}