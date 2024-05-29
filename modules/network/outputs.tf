output "vpc_id" {
  value = aws_vpc.oron-terraform-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.oron-terraform-subnet.*.id
}
