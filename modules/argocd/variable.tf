variable "namespace" {
  description = "The namespace to deploy Argo CD"
  type        = string
}

variable "argocd_ssh_secret_name" {
  description = "argocd ssh secret name"
  type        = string
}
