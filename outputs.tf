output "eks_cluster_name" {
  value = module.compute.eks_cluster_name
}

output "cluster_endpoint" {
  value = module.compute.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.compute.cluster_certificate_authority_data
}
