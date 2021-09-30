resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = var.cluster-name
  node_group_name = "${var.cluster-name}-default-node-group"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.private-subnet-ids
  disk_size       = 100
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
    CECO                                        = "${var.ceco}"
    Owner                                       = "${var.owner}"
    Environment                                 = "${var.environment}"
    asg_name                                    = "${var.asg_name}"
  }


}

resource "aws_autoscaling_group_tag" "eks_node_group_autoscaler_node_template_capacity_type" {
  for_each = toset(
    [for asg in flatten(
      [for resources in aws_eks_node_group.node_group.resources : resources.autoscaling_groups]
    ) : asg.name]
  )

  asg_name = each.value
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/eks.amazonaws.com/capacityType"
    value               = "SPOT"
    propagate_at_launch = false
  }
}

resource "aws_autoscaling_schedule" "off" {
  for_each = toset(
    [for asg in flatten(
      [for resources in module.eks-cluster.autoscaling-resources : resources.autoscaling_groups]
    ) : asg.name]
  )
  autoscaling_group_name = each.value
  scheduled_action_name  = "off_instance"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  start_time             = "${local.today_date}T23:59:00Z"
  recurrence             = "0 22 * * *"
  lifecycle {
    ignore_changes = [start_time]
  }
}