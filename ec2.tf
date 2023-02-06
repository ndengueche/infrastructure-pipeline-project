resource "aws_instance" "demo" {
  ami           = var.ami_id
  instance_type = var.instance_type
  monitoring = true
  ebs_optimized = true
  root_block_device {
    encrypted = true
  }
  iam_instance_profile = "test"
  tags = {
    Name =var.ec2_name_tag
  }
}