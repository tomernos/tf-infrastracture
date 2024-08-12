resource "aws_security_group" "this" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      cidr_blocks = ingress.value.cidr_ipv4
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      cidr_blocks = egress.value.cidr_ipv4
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
    }
  }

  tags = {
    Name = var.sg_name
  }
}

output "security_group_id" {
  value = aws_security_group.this.id
}