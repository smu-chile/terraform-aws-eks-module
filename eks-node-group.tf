module "eks__user_data" {
  source  = "terraform-aws-modules/eks/aws//modules/_user_data"
  version = "18.23.0"
  # insert the 1 required variable here
  pre_bootstrap_user_data = <<-EOT
  #!/bin/bash
  set -ex
  cat <<-EOF > /etc/profile.d/bootstrap.sh
  export USE_MAX_PODS=false
  export KUBELET_EXTRA_ARGS="--max-pods=110"
  EOF
  # Source extra environment variables in bootstrap script
  sed -i '/^set -o errexit/a\\nsource /etc/profile.d/bootstrap.sh' /etc/eks/bootstrap.sh
  EOT

}

resource "aws_launch_template" "morepods" {
  name_prefix            = "morepods"
  vpc_security_group_ids = [data.aws_security_group.node.id]
  user_data              = module.eks__user_data.user_data
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = var.cluster-name
  node_group_name = "${var.cluster-name}-default-node-group"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.private-subnet-ids

  launch_template {
    id      = aws_launch_template.morepods.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = var.desired-capacity
    max_size     = var.max-size
    min_size     = var.min-size
  }
  instance_types = [
    var.node-instance-type
  ]
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_eks_cluster.eks,
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly
  ]

  tags = {
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
    Name                                        = "${var.cluster-name}-default-node-group"
    Region                                      = "${var.tag-region}"
    Country                                     = "${var.country}"
    Owner                                       = "${var.owner}"
    Environment                                 = "${var.environment}"
  }
}
# Resource dedicated to dynamically assign a TAG to the Auto Scaling Groups of a cluster to be linked to the name of the instances. 
resource "aws_autoscaling_group_tag" "eks-node-group" {

  autoscaling_group_name = aws_eks_node_group.eks-node-group.resources[0].autoscaling_groups[0].name

  tag {
    key   = "Name"
    value = "${var.cluster-name}-asg"

    propagate_at_launch = true
  }
}