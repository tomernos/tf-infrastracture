resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_group_ids
  subnets            =  var.subnet_ids

  enable_deletion_protection = false

  tags = merge(var.tags,{
    Name = var.alb_name
  })
}

resource "aws_lb_target_group" "this" {
  for_each = var.target_group_names

  name     = each.key
  port     = each.value.port
  protocol = each.value.protocol
  vpc_id   = var.vpc_id

  dynamic "health_check" {
    for_each = can(each.value.health_check) ? toset(["health_check"]) : toset([])
    content {
      path                = each.value.health_check.path
      interval            = each.value.health_check.interval
      timeout             = each.value.health_check.timeout
      healthy_threshold   = each.value.health_check.healthy_threshold
      unhealthy_threshold = each.value.health_check.unhealthy_threshold
      matcher             = each.value.health_check.matcher
    }
  }
}

resource "aws_lb_listener" "this" {
  for_each = var.listeners 

  load_balancer_arn = aws_lb.this.arn
  port              = each.key
  protocol          = each.value.protocol

  default_action {
    type             = each.value.default_action.type
    target_group_arn = aws_lb_target_group.this[each.value.default_action.target_group_name].arn 
    order = lookup(each.value, "order", null)
  }
}

# output "alb_dns_name" {
#   value = aws_lb.this.dns_name
# }

output "target_group_arns_map" {
  value = { for tg in aws_lb_target_group.this : tg.name => tg.arn }
}