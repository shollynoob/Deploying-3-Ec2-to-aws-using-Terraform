aws_region     = "us-east-1"
env_prefix     = "altschool"
vpc_cidr_block = "192.168.0.0/26"
inbound_ports  = [22, 80]
instance_type  = "t2.micro"
domain_name    = "iamolusola.com"


subnet_block = {
  subnet-a = {
    az   = "us-east-1a"
    cidr = "192.168.0.0/28"
    name = "altschool_subnet_a"
  }
  subnet-b = {
    az   = "us-east-1b"
    cidr = "192.168.0.16/28"
    name = "altschool_subnet_b"
  }
  subnet-c = {
    az   = "us-east-1c"
    cidr = "192.168.0.32/28"
    name = "altschool_subnet_c"
  }
}



/*
192.168.0.0/28
192.168.0.16/28
192.168.0.32/28
192.168.0.48/28
*/