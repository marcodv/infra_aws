/* 
 * This module is used to deploy bastions for access to EKS worker nodes
 * 
 * The bastions will be deployed in public subnets
 * Each of them have these configurations
 *
 * - Kubectl already installed 
 * - Tagged by AZ and environment
 * - Port open: 22, 80, 443
 *
*/

data "aws_security_group" "bastions_sg" {
  filter {
    name   = "tag:Name"
    values = ["bastions-sg-${var.environment}-environment"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.environment}-environment"]
  }
}

data "aws_subnets" "public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-*-${var.environment}-environment"]
  }
}


/*==== Bastions for each AZ ======*/
resource "aws_instance" "bastions" {
  count                  = length(data.aws_subnets.public_subnet.ids)
  ami                    = var.bastions-ami
  availability_zone      = element(var.availability_zones, count.index)
  subnet_id              = element(data.aws_subnets.public_subnet.ids, count.index)
  key_name               = "ssh-key-bastion-${var.environment}-env"
  vpc_security_group_ids = [data.aws_security_group.bastions_sg.id]
  instance_type          = "t2.micro"
  user_data              = file("${path.module}/kubectl_repo.sh")
  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }


  tags = {
    Name = "Bastion-${element(var.availability_zones, count.index)}-${var.environment}-env"
  }
}
