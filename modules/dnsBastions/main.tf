/* 
 * This module is used to create DNS entries in order to
 *
 * make port forward from the bastions to local environment
 *
 * for using kubectl from local since EKS is using private endpoint
 * 
 * These are the dns entries
 *
 * - dev.bastion1.noahdev.org
 * - dev.bastion2.noahdev.org
 * - prod.bastion1.noahdev.org
 * - prod.bastion2.noahdev.org
 *
*/

data "aws_instance" "bastion1" {

  filter {
    name   = "tag:Name"
    values = ["Bastion-eu-west-1b-${var.environment}-env"]
  }
}

data "aws_instance" "bastion2" {

  filter {
    name   = "tag:Name"
    values = ["Bastion-eu-west-1a-${var.environment}-env"]
  }
}

resource "aws_route53_record" "bastion1_entry" {
  zone_id  = var.zone_id
  name    = "${var.environment}.bastion1.noahdev.org"
  type    = "A"
  ttl     = "300"
  records = [data.aws_instance.bastion1.public_ip]
}

resource "aws_route53_record" "bastion2_entry" {
  zone_id  = var.zone_id
  name    = "${var.environment}.bastion2.noahdev.org"
  type    = "A"
  ttl     = "300"
  records = [data.aws_instance.bastion2.public_ip]
}