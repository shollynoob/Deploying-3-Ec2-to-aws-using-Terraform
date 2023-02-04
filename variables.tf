variable "env_prefix" {}
variable "aws_region" {}
variable "vpc_cidr_block" {}
variable "instance_type" {}
variable "domain_name" {}



variable "inbound_ports" {
  type    = list(number)
  default = []
}

variable "subnet_block" {
  type    = map(any)
  default = {}
}
