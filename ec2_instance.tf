#determine the latest ubuntu ami id 
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}



#create instance
resource "aws_instance" "altschool_server" {
  for_each                    = aws_subnet.altschool_subnet
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = "altschool"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_default_security_group.altschool_sg.id]
  subnet_id                   = each.value.id

  tags = {
    Name = "${var.env_prefix}-server-${each.key}"
  }

}




