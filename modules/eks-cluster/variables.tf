variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "my_local_cluster"
}

variable "region" {
  type        = string
  description = "AWS region for the EKS cluster"
  default     = "us-east-1"
}

variable "account_id" {
  type        = string
  description = "AWS account ID for the EKS cluster and all the resources"
  default     = "123412341234"
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to create in the EKS cluster"
}
