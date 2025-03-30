output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority" {
  value = module.eks.cluster_certificate_authority
}

output "node_group_role_arn" {
  value = module.eks.node_role_arn
}

output "user_alb_dns_name" {
  value = data.aws_lb.user_alb.dns_name
}

output "user_alb_zone_id" {
  value = data.aws_lb.user_alb.zone_id
}
