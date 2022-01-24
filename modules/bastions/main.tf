/*==== Bastions for each AZ ======*/
resource "aws_instance" "bastions" {
  //depends_on             = [module.networking.aws_security_group.bastions_sg]
  count                  = length(var.public_subnets_id)
  ami                    = var.bastions-ami
  availability_zone      = element(var.availability_zones, count.index)
  subnet_id              = element(var.public_subnets_id, count.index)
  key_name               = "bastion-ssh-key-${var.environment}"
  vpc_security_group_ids = var.bastions_sg
  instance_type          = "t2.micro"
  user_data              = file("${path.module}/kubectl_repo.sh")

  tags = {
    Name = "Bastion-${element(var.availability_zones, count.index)}"
  }
}
