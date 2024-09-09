variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "routes" {
  description = "Map of routes"
  type = map(object({
    cidr_block = string
    target_type = string
  }))
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet names to associate with the route table"
  type        = map(string)
}

variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

