module "cluster-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.3.0"

  name        = "cluster-sg"
  description = "EKS node security groups"
  vpc_id      = var.vpc-id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      description              = "Allow pods to communicate with the cluster API Server"
      source_security_group_id = module.node-sg.security_group_id
    },
  ]

  number_of_computed_ingress_with_source_security_group_id = 1

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = {
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
    Name                                        = "${var.cluster-name}-eks-cluster-sg"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
    Region                                      = "${var.tag-region}"
    Country                                     = "${var.country}"
    Owner                                       = "${var.owner}"
    Environment                                 = "${var.environment}"
  }
}

# NODES SECURITY GROUPS

module "node-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.3.0"

  name        = "node-sg"
  description = "EKS node security groups"
  vpc_id      = var.vpc-id

  ingress_cidr_blocks = [data.aws_vpc.eks.cidr_block]
  ingress_with_self = [
    {
      rule = "all-all"
    },
  ]
  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 1025
      to_port                  = 65535
      protocol                 = "tcp"
      description              = "Allow EKS Control Plane"
      source_security_group_id = module.cluster-sg.security_group_id
    },
  ]

  number_of_computed_ingress_with_source_security_group_id = 1

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = {
    Name                                        = "${var.cluster-name}-eks-node-sg"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
    Region                                      = "${var.tag-region}"
    Country                                     = "${var.country}"
    Owner                                       = "${var.owner}"
    Environment                                 = "${var.environment}"
  }

}

