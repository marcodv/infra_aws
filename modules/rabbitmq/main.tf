/* 
 * This module is used to deploy a RabbitMQ with a single node instance
 *
 *
*/

resource "aws_mq_broker" "rabbitmq_instance" {
  broker_name = "rabbitMQInstance"

  configuration {
    id       = aws_mq_configuration.test.id
    revision = aws_mq_configuration.test.latest_revision
  }

  engine_type        = "ActiveMQ"
  engine_version     = var.rabbitmq_settings.engine_version
  storage_type       = "ebs"
  host_instance_type = var.rabbitmq_settings.host_instance_type
  security_groups    = ["${var.security_group_ids}"]
  subnet_ids         = ["${var.subnet_group_name}"]

  user {
    username = "ExampleUser"
    password = "MindTheGap"
  }
  logs {
    general = true
  }
}
