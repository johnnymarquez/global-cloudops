module "useast" {
  source = "./us-east-1"
}

module "euwest" {
  source = "./eu-west-1"
}

module "route53" {
  source = "./route53"

  alb_dns_name_us = module.useast.user_alb_dns_name
  alb_zone_id_us  = module.useast.user_alb_zone_id

  alb_dns_name_eu = module.euwest.user_alb_dns_name
  alb_zone_id_eu  = module.euwest.user_alb_zone_id
}
