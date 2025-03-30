resource "aws_route53_zone" "main" {
  name = "api.johnnymarquez.dev"
}

resource "aws_route53_record" "user_us" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "user.api.johnnymarquez.dev"
  type    = "A"

  alias {
    name                   = var.alb_dns_name_us
    zone_id                = var.alb_zone_id_us
    evaluate_target_health = true
  }

  set_identifier = "us-east-1"
  latency_routing_policy {
    region = "us-east-1"
  }
}

resource "aws_route53_record" "user_eu"_

