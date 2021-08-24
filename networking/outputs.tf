# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.beautiful_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.beautiful_rds_subnetgroup.*.name
}

output "db_security_group" {
  value = aws_security_group.beautiful_sg["rds"].id
}

output "public_sg" {
  value = aws_security_group.beautiful_sg["public"].id
}

output "public_subnets" {
  value = aws_subnet.beautiful_public_subnet.*.id
}