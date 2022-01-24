resource "aws_launch_template" "eks_launch_group_template" {
  image_id               = var.worker_node_ami_id
  instance_type          = var.workers_nodes_instance_type[0]
  name                   = "eks-launch-template-${var.environment}-env"
  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "node-group-instance-${var.environment}-env"
    }
  }
}
