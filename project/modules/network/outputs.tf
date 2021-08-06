output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "public_subnet_cidrs" {
  value = aws_subnet.public_subnet.*.cidr_block
}

output "private_subnet_cidrs" {
  value = aws_subnet.private_subnet.*.cidr_block
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "elastic_ip_for_nat_gw_ids" {
  value = aws_eip.elastic_ip_for_nat_gw.*.id
}

output "nat_gw_ids" {
  value = aws_nat_gateway.nat_gw.*.id
}

output "nat_gw_public_ips" {
  value = aws_nat_gateway.nat_gw.*.public_ip
}

output "private_route_table_ids" {
  value = aws_route_table.private_route_table.*.id
}

output "bastion_server_public_ip" {
  value = aws_instance.bastion_server.*.public_ip
}

output "web_server_private_ip" {
  value = aws_instance.web_server.*.private_ip
}

output "alb_hostname" {
  value = aws_alb.alb.dns_name
}
