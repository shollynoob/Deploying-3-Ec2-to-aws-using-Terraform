locals {
  subnets = [
    for subnet in aws_subnet.altschool_subnet : subnet.id
  ]

  instance_ids = [
    for instance in aws_instance.altschool_server : instance.id
  ]
}


