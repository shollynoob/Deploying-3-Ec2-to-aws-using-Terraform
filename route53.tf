resource "aws_route53_zone" "iamolusola" {
  name = var.domain_name
}


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.iamolusola.zone_id
  name    = "terraform-test.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.altschool_elb.dns_name
    zone_id                = aws_lb.altschool_elb.zone_id
    evaluate_target_health = true
  }
}