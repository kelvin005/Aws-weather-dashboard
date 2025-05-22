# EC2 instance
resource "aws_instance" "web" {
  ami                    = var.ami 
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet
  vpc_security_group_ids = var.security_group
  key_name = var.key_name
  user_data = file("${path.module}/script.sh")
  tags = var.tags
}

