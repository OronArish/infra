output "eks_cluster_name" {
  value = aws_eks_cluster.eks-cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority.0.data
}
