variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster and node group."
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type of the worker nodes."
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of worker nodes in the EKS node group."
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of worker nodes in the EKS node group."
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of worker nodes in the EKS node group."
  type        = number
}

variable "common_tags" {
  description = "Common tags to apply to all resources."
  type        = map(string)
}

variable "env" {
  description = "Deployment environment (e.g., staging, production)."
  type        = string
}
