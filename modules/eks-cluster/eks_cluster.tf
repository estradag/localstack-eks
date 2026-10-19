resource "aws_eks_cluster" "my_local_cluster" {
  name   = var.cluster_name
  region = var.region

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster_role.arn
  version  = "1.37"

  vpc_config {
    subnet_ids = [
      aws_subnet.az1.id,
      aws_subnet.az2.id,
      aws_subnet.az3.id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.cluster_AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "node_group_1" {
  cluster_name    = aws_eks_cluster.my_local_cluster.name
  region          = var.region
  node_group_name = "node-group-1"
  node_role_arn   = aws_iam_role.cluster_role.arn
  subnet_ids      = [aws_subnet.az1.id, aws_subnet.az2.id, aws_subnet.az3.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.cluster_AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "node_group_2" {
  cluster_name    = aws_eks_cluster.my_local_cluster.name
  region          = var.region
  node_group_name = "node-group-2"
  node_role_arn   = aws_iam_role.cluster_role.arn
  subnet_ids      = [aws_subnet.az1.id, aws_subnet.az2.id, aws_subnet.az3.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.cluster_AmazonEC2ContainerRegistryReadOnly,
  ]
}
