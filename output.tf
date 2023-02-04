output "altschool_server_public_ip" {
  value = [for instance in aws_instance.altschool_server: instance.public_ip] 
}



resource "local_file" "Ip_address" {
  filename = "hosts"
  content  = join("\n", [for instance in aws_instance.altschool_server : instance.public_ip])
}



  output "aws_lb_altschool_elb_dns_name" {
    value = aws_lb.altschool_elb.dns_name
  }

output "aws_lb_altschool_elb_zone_id" {
    value = aws_lb.altschool_elb.zone_id
  }







