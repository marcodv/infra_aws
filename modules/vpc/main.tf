/* Usage:
 *
 * Example of 'foo_bar' module in `foo_bar.tf`.
 *
 * - list item 1
 * - list item 2
 *
 * Even inline **formatting** in _here_ is possible.
 * and some [link](https://domain.com/)
 *
 * * list item 3
 * * list item 4
*/

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.environment}-environment"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-${var.environment}-enrivonment"
  }
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  count      = length(var.public_subnets_cidr)
  depends_on = [aws_internet_gateway.ig]

  tags = {
    Name = "nat-eip-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/* NAT */
resource "aws_nat_gateway" "nat" {
  depends_on    = [aws_internet_gateway.ig, aws_subnet.public_subnet]
  count         = length(var.public_subnets_cidr)
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)

  tags = {
    Name = "nat-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.private_subnets_cidr)

  tags = {
    Name = "private-route-table-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-route-table-${var.environment}-environment"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(aws_subnet.private_subnet)
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

/*==== Subnets ======*/
/* Public subnet */
resource "aws_subnet" "public_subnet" {

  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${element(var.availability_zones, count.index)}-${var.environment}-environment"
    // Tag needed for bind EKS to ALB created from terraform
    "kubernetes.io/role/elb"                           = "1"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
    "ingress.k8s.aws/resource"                         = "LoadBalancer"
    "elbv2.k8s.aws/cluster"                            = "eks-${var.environment}-env"
  }
}

/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name                                               = "private-subnet-${element(var.availability_zones, count.index)}-${var.environment}-environment"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
  }
}

/* DB Subnets */
resource "aws_subnet" "db_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.db_subnets_cidr)
  cidr_block              = element(var.db_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "db-private-subnet-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/*==== ALB Security Group ======*/
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg-${var.environment}-environment"
  description = "ALB sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.alb_ingress_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB sg ${var.environment} environment"
  }
}

/*==== Bastion Security Group ======*/
resource "aws_security_group" "bastions_sg" {
  name        = "bastions-sg-${var.environment}-environment"
  description = "Bastion sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.bastion_ingress_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG Bastions ${var.environment} environment"
  }
}

/*==== Private instances Security Group ======*/
resource "aws_security_group" "private_instances_sg" {
  name        = "private-instances-sg-${var.environment}-environment"
  description = "Private instances sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.private_instances_ingress_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.public_subnets_cidr
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG private instances in ${var.environment} environment"
  }
}

/*==== RDS Security Group ======*/
resource "aws_security_group" "db_sg" {
  name        = "db-sg-${var.environment}-environment"
  description = "DB sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.sg_db_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      // Allow connection only FROM private subnets
      cidr_blocks = var.private_subnets_cidr
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    // Allow outbound only TO private subnets
    cidr_blocks = var.private_subnets_cidr
  }

  tags = {
    Name = "SG DB for ${var.environment} environment"
  }
}

/*==== EKS Security Group ======*/
resource "aws_security_group" "eks_sg" {
  name        = "eks-sg-${var.environment}-environment"
  description = "EKS sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  # Inbound Rule
  ingress {
    description = "EKS Ingress rule"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "SG EKS nodes for ${var.environment} environment"
  }
}

/*==== ACL for Public subnet ======*/
resource "aws_network_acl" "acl_public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc, aws_subnet.public_subnet]
  count      = length(var.public_subnets_cidr)
  subnet_ids = ["${element(aws_subnet.public_subnet.*.id, count.index)}"]

  dynamic "ingress" {
    for_each = var.acl_public_subnet_rule.ingress_rule

    content {
      protocol   = "tcp"
      rule_no    = ingress.value.rule_no
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name                                               = "Public subnet ACL in ${element(var.availability_zones, count.index)}"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
  }
}

/*==== ACL for Private subnet ======*/
resource "aws_network_acl" "acl_private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc, aws_subnet.private_subnet]
  count      = length(var.private_subnets_cidr)
  subnet_ids = ["${element(aws_subnet.private_subnet.*.id, count.index)}"]

  dynamic "ingress" {
    for_each = var.acl_private_subnet_rule.ingress_rule
    content {
      protocol   = "tcp"
      rule_no    = ingress.value.rule_no
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Private subnet ACL in ${element(var.availability_zones, count.index)}"
  }
}

/*==== ACL for DB Private subnet ======*/
resource "aws_network_acl" "acl_db_private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc, aws_subnet.db_subnets]
  count      = length(var.db_subnets_cidr)
  subnet_ids = ["${element(aws_subnet.db_subnets.*.id, count.index)}"]

  dynamic "ingress" {
    for_each = var.acl_db_rule.ingress_rule
    content {
      protocol   = "tcp"
      rule_no    = ingress.value.rule_no
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "DB ACL ${element(var.availability_zones, count.index)}"
  }
}
