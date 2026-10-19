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

resource "aws_iam_role" "namespace_role" {
  for_each = toset(var.namespaces)

  name = "${each.key}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "pods.eks.amazonaws.com"
      }
      Action = ["sts:AssumeRole", "sts:TagSession"]
    }]
  })
}

# Cluster IAM role should not have permissions required for specific applications or services
# The Cluster IAM role is what allows the control plane to manage cluster infrastructure
# Service/application specific permissions should be handled by EKS pod identity instead
resource "aws_iam_policy" "namespace_policy" {
  for_each = toset(var.namespaces)

  name        = "${each.key}-namespace-policy"
  description = "Minimal permissions policy from an external JSON file"
  path        = "/"

  # Load the external JSON file directly
  policy = templatefile("iam-policies/${each.key}.json.tmpl",
    {
      region     = var.region,
      account_id = var.account_id
    }
  )
}

resource "aws_iam_role_policy_attachment" "namespace_policy_attachment" {
  for_each = toset(var.namespaces)

  role       = aws_iam_role.namespace_role[each.key].name
  policy_arn = aws_iam_policy.namespace_policy[each.key].arn
}

resource "aws_eks_pod_identity_association" "namespace_pod_identity_association" {
  for_each = toset(var.namespaces)

  cluster_name    = aws_eks_cluster.my_local_cluster.name
  region          = var.region
  namespace       = each.key
  service_account = "${each.key}-service-account"
  role_arn        = aws_iam_role.namespace_role[each.key].arn
}
