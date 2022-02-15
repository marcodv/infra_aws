// Create Parameters group for Elasticache cluster
resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params-${var.environment}-env"
  family = var.elasticache_setting.family
}

// Set the subnet for Redis
resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "redis-cache-subnet"
  subnet_ids = [var.subnet_group_name]
}

// Create ElastiCache cluster based on Redis and on 1 node atm
resource "aws_elasticache_cluster" "elasticache_cluster" {
  cluster_id           = "cluster-${var.environment}-env"
  engine               = "${var.elasticache_setting.engine}"
  node_type            = "${var.elasticache_setting.node_type}"
  num_cache_nodes      = "${var.elasticache_setting.num_cache_nodes}"
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = "${var.elasticache_setting.engine_version}"
  port                 = "${var.elasticache_setting.port}"
  // the next create the instance in the first subnet
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet.id
  security_group_ids   = var.security_group_ids
}

// Create Redis user
resource "aws_elasticache_user" "redis_user" {
  user_id       = "testUserId"
  user_name     = "${var.redis_credentials.username}-${var.environment}-env"
  access_string = "on ~app::* +@all"
  engine        = "REDIS"
  passwords     = ["${var.redis_credentials.password}"]
}

// Create Redis user group and associate the previous user to this group
resource "aws_elasticache_user_group" "redis_group" {
  engine        = "REDIS"
  user_group_id = "redis-group-${var.environment}-env"
  user_ids      = [aws_elasticache_user.redis_user.user_id]
}