data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.my_local_cluster.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.my_local_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.my_local_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}

resource "kubernetes_namespace_v1" "namespaces" {
  for_each = toset(var.namespaces)
  
  metadata {
    annotations = {
      env = "staging"
    }

    labels = {
      version = "v1"
    }

    name = each.key
  }
}
