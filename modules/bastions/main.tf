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

/*==== Bastions for each AZ ======*/
resource "aws_instance" "bastions" {
  count                  = length(var.public_subnets_id)
  ami                    = var.bastions-ami
  availability_zone      = element(var.availability_zones, count.index)
  subnet_id              = element(var.public_subnets_id, count.index)
  key_name               = "ssh-key-bastion-${var.environment}-env"
  vpc_security_group_ids = var.bastions_sg
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
