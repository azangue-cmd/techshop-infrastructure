provider "aws" {
  region = "us-east-1"
}

module "network" {
  source         = "../../modules/network"
  env            = "dev"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24","10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24","10.0.4.0/24"]
  azs            = ["us-east-1a", "us-east-1b"]
}

module "eks" {
  source          = "../../modules/eks"
  env             = "dev"
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
  desired_capacity = 2
  max_capacity     = 3
  min_capacity     = 1
}

module "db" {
  source          = "../../modules/db"
  env             = "dev"
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
  db_name         = "techshop"
  db_user         = "admin"
  db_password     = "StrongPassword123!"
  sg_ids          = [] # DB security groups
}

