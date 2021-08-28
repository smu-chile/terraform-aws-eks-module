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
  type = string
}
variable "instance-type" {
  type = string
}
variable "k8s-version" {
  type = string
}
variable "public-key" {
  type = string
}
variable "desired-capacity" {
  type = string
}
variable "max-size" {
  type = string
}
variable "min-size" {
  type = string
}
variable "node-instance-type" {
  type = string
}
variable "availability-zones" {
  type = string
}
variable "vpc-id" {
  type = string
}
variable "environment" {
  type = string
}
variable "tag-region" {
  type = string
}
variable "country" {
  type = string
}
variable "ceco" {
  type = string
}
variable "owner" {
  type = string
}
variable "private-subnet-ids" {
}
variable "public-subnet-ids" {
}


