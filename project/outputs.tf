output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "public_subnet_cidrs" {
  value = module.network.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = module.network.private_subnet_cidrs
}

output "igw_id" {
  value = module.network.igw_id
}

output "public_route_table_id" {
  value = module.network.public_route_table_id
}

output "elastic_ip_for_nat_gw_ids" {
  value = module.network.elastic_ip_for_nat_gw_ids
}

output "nat_gw_ids" {
  value = module.network.nat_gw_ids
}

output "nat_gw_public_ips" {
  value = module.network.nat_gw_public_ips
}

output "private_route_table_ids" {
  value = module.network.private_route_table_ids
}

output "bastion_server_public_ip" {
  value = module.network.bastion_server_public_ip
}

output "web_server_private_ip" {
  value = module.network.web_server_private_ip
}

output "alb_hostname" {
  value = module.network.alb_hostname
}
