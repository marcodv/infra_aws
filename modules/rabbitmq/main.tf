/* 
 * This module is used to deploy a RabbitMQ with a single node instance
 *
 *
*/

resource "aws_mq_broker" "rabbitmq_instance" {
  broker_name = "rabbitMQInstance-${var.environment}-env"

  engine_type        = "ActiveMQ"
  engine_version     = var.rabbitmq_settings.engine_version
  //storage_type       = "ebs"
  host_instance_type = var.rabbitmq_settings.host_instance_type
  security_groups    = "${var.security_group_id_rabbitmq}"
  subnet_ids         = ["${var.subnet_group_name_rabbitmq}"]

  user {
    username = "ExampleUser"
    password = "MindTheGap12"
  }

  logs {
    general = true
  }
  
}
