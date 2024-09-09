variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag of the VPC"
  type        = string
}

variable "tags" {
  description = "Tags for the VPC"
  type        = map(string) 
}