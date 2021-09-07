variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "The AWS Region to deploy EKS"
}
variable "eks-cw-logging" {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  type        = list(any)
  description = "Enable EKS CWL for EKS components"
}

### variables modules

variable "cluster-name" {
  type        = string
  description = "nombre del cluster. P.e: k8s-virginia-almaceneros-frontend-develop"
}
variable "k8s-version" {
  type        = string
  description = "versión de kubernetes p.e: 1.17"
}
variable "desired-capacity" {
  type        = string
  description = "configuración de escalamiento"
}
variable "max-size" {
  type        = string
  description = "configuración de escalamiento"
}
variable "min-size" {
  type        = string
  description = "configuración de escalamiento"
}
variable "node-instance-type" {
  type        = string
  description = "Tipo de instancia de los nodos. P.e: t2.large"
}
variable "vpc-id" {
  type        = string
  description = "Id de la VPC"

}
variable "environment" {
  type        = string
  description = "Ambiente, p.e: development, staging, production"
}
variable "tag-region" {
  type        = string
  default     = "LATAM"
  description = "Tag referente a región"
}
variable "country" {
  type        = string
  default     = "CL"
  description = "Tag referente a país"
}
variable "ceco" {
  type        = string
  description = "Tag referente a centro de costo"
}
variable "owner" {
  type        = string
  description = "Tag referente a owner. P.e: PRODUCTOS DIGITALES"
}
variable "private-subnet-ids" {
  description = "id de subnet red privada donde se alojará el cluster"
}

variable "policy-name" {
  description = "Name of iam policy"
  type        = string
}


