
output "kubeconfig" {
  value = local.kubeconfig
}

output "config-map-aws-auth" {
  value = module.self_managed_node_group.aws_auth_configmap_yaml
}

output "route53-arn" {
  value = aws_iam_policy.route53.arn
}

# output "autoscaling-resources" {
#   value = aws_eks_node_group.eks-node-group.resources
# }