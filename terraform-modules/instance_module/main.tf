resource "aws_instance" "this" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}

resource "aws_lb_target_group_attachment" "this" {
  for_each = { for k, v in var.target_group_attachments : k => v if v != "" }
  

  target_group_arn = each.value
  target_id        = aws_instance.this.id
  port             = 80

  lifecycle {
    precondition {
      condition     = length(each.value) > 0
      error_message = "Target Group ARN must not be empty."
    }
  }
}