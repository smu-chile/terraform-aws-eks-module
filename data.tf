
data "aws_security_group" "cluster" {
  vpc_id = var.vpc-id
  name   = module.cluster-sg.security_group_name
}

data "aws_security_group" "node" {
  vpc_id = var.vpc-id
  name   = module.node-sg.security_group_name
}

data "aws_vpc" "eks" {
  id = var.vpc-id
}