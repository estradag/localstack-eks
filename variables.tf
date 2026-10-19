variable "region" {
  type        = string
  description = "AWS region for the EKS cluster"
}

variable "account_id" {
  type        = string
  description = "AWS account ID for the EKS cluster and all the resources"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to create in the EKS cluster"
}
