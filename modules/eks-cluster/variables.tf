variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "my_local_cluster"
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to create in the EKS cluster"
}
