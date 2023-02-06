resource "aws_instance" "demo" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name =var.ec2_name_tag
  }
}