# resource "aws_eks_node_group" "eks-node-group" {
#   cluster_name    = var.cluster-name
#   node_group_name = "${var.cluster-name}-default-node-group"
#   node_role_arn   = aws_iam_role.node.arn
#   subnet_ids      = var.private-subnet-ids
#   disk_size       = 100
#   scaling_config {
#     desired_size = var.desired-capacity
#     max_size     = var.max-size
#     min_size     = var.min-size
#   }
#   instance_types = [
#     var.node-instance-type
#   ]
#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_eks_cluster.eks,
#     aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly
#   ]

#   tags = {
#     "kubernetes.io/cluster/${var.cluster-name}" = "owned"
#     Name                                        = "${var.cluster-name}-default-node-group"
#     Region                                      = "${var.tag-region}"
#     Country                                     = "${var.country}"
#     CECO                                        = "${var.ceco}"
#     Owner                                       = "${var.owner}"
#     Environment                                 = "${var.environment}"
#   }
# }
# # Resource dedicated to dynamically assign a TAG to the Auto Scaling Groups of a cluster to be linked to the name of the instances. 
# resource "aws_autoscaling_group_tag" "eks-node-group" {

#   autoscaling_group_name = aws_eks_node_group.eks-node-group.resources[0].autoscaling_groups[0].name

#   tag {
#     key   = "Name"
#     value = "${var.cluster-name}-asg"

#     propagate_at_launch = true
#   }
# }



module "self_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/self-managed-node-group"

  name                = var.cluster-name
  cluster_name        = aws_eks_cluster.eks.id
  cluster_version     = var.k8s-version
  cluster_endpoint    = aws_eks_cluster.eks.endpoint
  cluster_auth_base64 = aws_eks_cluster.eks.certificate_authority.data

  vpc_id     = var.vpc_id
  subnet_ids = var.private-subnet-ids
  vpc_security_group_ids = [
    data.aws_security_group.cluster.id
  ]

  min_size     = var.mix-size
  max_size     = var.max-size
  desired_size = var.desired-capacity

  # launch_template_name   = "separate-self-mng"
  instance_type          = var.node-instance-type

  tags = {
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
    Name                                        = "${var.cluster-name}-default-node-group"
    Region                                      = "${var.tag-region}"
    Country                                     = "${var.country}"
    CECO                                        = "${var.ceco}"
    Owner                                       = "${var.owner}"
    Environment                                 = "${var.environment}"
  }
}