resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = {for k, v in var.routes : k => v if v.target_type != "local"}
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.target_type == "internet_gateway" ? var.internet_gateway_id : null
    }
  }

  tags = {
    Name = var.route_table_name
  }
}



resource "aws_route_table_association" "this" {
  for_each = var.subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.this.id

}


output "route_table_id" {
  value = aws_route_table.this.id
}

