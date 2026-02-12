resource "aws_elasticache_subnet_group" "redis_subnets" {
  name       = "techshop-redis-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "techshop-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnets.name
  parameter_group_name = "default.redis6.x"
}

