resource "aws_instance" "this" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  availability_zone = var.availability_zone
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}

output "instance_id" {
  value = aws_instance.this.id
}

