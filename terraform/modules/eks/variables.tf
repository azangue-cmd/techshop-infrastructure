variable "cluster_name" {}
variable "vpc_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "node_group_name" {}
variable "node_instance_type" { default = "t3.medium" }
variable "desired_capacity" { default = 2 }

