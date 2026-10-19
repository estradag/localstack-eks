output "cluster_endpoint" {
  value       = aws_eks_cluster.my_local_cluster.endpoint
  description = "EKS cluster endpoint"
}

output "cluster_certificate_authority" {
  value       = aws_eks_cluster.my_local_cluster.certificate_authority[0].data
  description = "EKS cluster certificate authority data"
}
