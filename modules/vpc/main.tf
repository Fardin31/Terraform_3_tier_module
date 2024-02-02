resource "aws_vpc" "this_aws_3_tier" {
  cidr_block       = var.aws_vpc.cidr_block
  instance_tenancy = var.aws_vpc.instance_tenancy
  tags             = var.vpc_tags
}
//subnet_for_vpc
resource "aws_subnet" "this_aws_subnet" {
  count = length(var.subnet_names)

  cidr_block        = var.cidr_blocks[count.index]
  availability_zone = element(var.availability_zones, count.index)
  vpc_id            = aws_vpc.this_aws_3_tier.id

  tags = {
    Name = element(var.subnet_names, count.index)
  }
}
resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_aws_3_tier.id
  tags = {
    Name = var.ig_name
  }
}

#EIP
resource "aws_eip" "this_eip" {
  domain = var.eip_domain
}
#NAT
resource "aws_nat_gateway" "this_nat" {
  allocation_id = aws_eip.this_eip.id
  subnet_id     = var.nat_subnet_id

  tags = {
    Name = var.nat_ig_name
  }
  depends_on = [aws_internet_gateway.this_igw]
}
resource "aws_route_table" "this_public_rtb" {
  vpc_id = aws_vpc.this_aws_3_tier.id

  route {
    cidr_block = var.route_table.cidr_block
    gateway_id = aws_internet_gateway.this_igw.id
  }
  tags = {
    Name = var.public_route_name
  }
}
resource "aws_route_table" "this_private_rtb" {
  vpc_id = aws_vpc.this_aws_3_tier.id

  route {
    cidr_block = var.route_table.cidr_block
    gateway_id = aws_nat_gateway.this_nat.id
  }
  tags = {
    Name = var.private_route_name
  }
}
locals {
  public_subnet_indices  = [0, 1]
  private_subnet_indices = [2, 3]
}
# Associate public subnets with the public route table
resource "aws_route_table_association" "this_pub_rtb_asso" {
  count          = length(var.public_subnet_indices)
  subnet_id      = element(aws_subnet.this_aws_subnet[*].id, var.public_subnet_indices[count.index])
  route_table_id = aws_route_table.this_public_rtb.id
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "this_pri_rtb_asso" {
  count          = length(var.private_subnet_indices)
  subnet_id      = element(aws_subnet.this_aws_subnet[*].id, var.private_subnet_indices[count.index])
  route_table_id = aws_route_table.this_private_rtb.id
}

    