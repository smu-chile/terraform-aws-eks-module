
output "kubeconfig" {
  value = local.kubeconfig
}

output "config-map-aws-auth" {
  value = local.config-map-aws-auth
}

output "route53-arn" {
  value = aws_iam_policy.route53.arn
}

output "autoscaling-groups" {
  value = aws_eks_node_group.eks-node-group.resources
}