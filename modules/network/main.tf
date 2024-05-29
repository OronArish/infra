resource "aws_vpc" "oron-terraform-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(var.common_tags, { Name = "oron-terraform-vpc" })
}

resource "aws_subnet" "oron-terraform-subnet" {
  count                   = var.deploy_single_subnet ? 1 : length(var.subnets_cidrs)
  vpc_id                  = aws_vpc.oron-terraform-vpc.id
  cidr_block              = var.subnets_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.common_tags, { Name = format("oron-terraform-subnet-%d", count.index + 1) })
}


resource "aws_internet_gateway" "oron-terraform-IGW" {
  vpc_id = aws_vpc.oron-terraform-vpc.id
  tags   = merge(var.common_tags, { Name = "oron-terraform-IGW" })
}

resource "aws_route_table" "oron-terraform-public-rt" {
  vpc_id = aws_vpc.oron-terraform-vpc.id
  tags   = merge(var.common_tags, { Name = "oron-terraform-RT" })

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.oron-terraform-IGW.id
  }
}

resource "aws_route_table_association" "oron-terraform-public-rta" {
  count          = var.deploy_single_subnet ? 1 : length(var.subnets_cidrs)
  subnet_id      = aws_subnet.oron-terraform-subnet[count.index].id
  route_table_id = aws_route_table.oron-terraform-public-rt.id
}

