## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster-sg"></a> [cluster-sg](#module\_cluster-sg) | terraform-aws-modules/security-group/aws | 4.3.0 |
| <a name="module_node-sg"></a> [node-sg](#module\_node-sg) | terraform-aws-modules/security-group/aws | 4.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.eks-node-group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/eks_node_group) | resource |
| [aws_iam_instance_profile.node](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.route53](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role) | resource |
| [aws_iam_role.node](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [aws_security_group.node](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [aws_vpc.eks](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS Region to deploy EKS | `string` | `"us-east-1"` | no |
| <a name="input_ceco"></a> [ceco](#input\_ceco) | Tag referente a centro de costo | `string` | n/a | yes |
| <a name="input_cluster-name"></a> [cluster-name](#input\_cluster-name) | nombre del cluster. P.e: k8s-virginia-almaceneros-frontend-develop | `string` | n/a | yes |
| <a name="input_country"></a> [country](#input\_country) | Tag referente a país | `string` | `"CL"` | no |
| <a name="input_desired-capacity"></a> [desired-capacity](#input\_desired-capacity) | configuración de escalamiento | `string` | n/a | yes |
| <a name="input_eks-cw-logging"></a> [eks-cw-logging](#input\_eks-cw-logging) | Enable EKS CWL for EKS components | `list(any)` | [] | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente, p.e: development, staging, production | `string` | n/a | yes |
| <a name="input_k8s-version"></a> [k8s-version](#input\_k8s-version) | versión de kubernetes p.e: 1.17 | `string` | n/a | yes |
| <a name="input_max-size"></a> [max-size](#input\_max-size) | configuración de escalamiento | `string` | n/a | yes |
| <a name="input_min-size"></a> [min-size](#input\_min-size) | configuración de escalamiento | `string` | n/a | yes |
| <a name="input_node-instance-type"></a> [node-instance-type](#input\_node-instance-type) | Tipo de instancia de los nodos. P.e: t2.large | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Tag referente a owner. P.e: PRODUCTOS DIGITALES | `string` | n/a | yes |
| <a name="input_private-subnet-ids"></a> [private-subnet-ids](#input\_private-subnet-ids) | id de subnet red privada donde se alojará el cluster | `any` | n/a | yes |
| <a name="input_tag-region"></a> [tag-region](#input\_tag-region) | Tag referente a región | `string` | `"LATAM"` | no |
| <a name="input_vpc-id"></a> [vpc-id](#input\_vpc-id) | Id de la VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config-map-aws-auth"></a> [config-map-aws-auth](#output\_config-map-aws-auth) | n/a |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_route53-arn"></a> [route53-arn](#output\_route53-arn) | n/a |
