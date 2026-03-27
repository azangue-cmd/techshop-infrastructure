module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnets         = var.private_subnet_ids
  vpc_id          = var.vpc_id

  node_groups = {
    default = {
      desired_capacity = var.desired_capacity
      instance_type    = var.node_instance_type
      subnet_ids       = var.public_subnet_ids
    }
  }
}

