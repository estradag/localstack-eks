variable "region" {
    type = string
    description = "AWS region on which all resources are being created"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to create in the EKS cluster"
}
