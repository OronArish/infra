variable "region" {
  description = "AWS region to deploy resource into"
  type        = string
}

variable "env" {
  description = "Deployment environment"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources."
  type        = map(string)
}

variable "deploy_single_subnet" {
  description = "If set to true, only one subnet will be deployed."
  type        = bool
}

variable "availability_zones" {
  description = "List of availability zones to deploy resources into"
  type        = list(string)
}

variable "deploy_load_balancer" {
  description = "If set to true, a load balancer will be deployed."
  type        = bool
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "subnets_cidrs" {
  description = "List of CIDR blocks for the subnets."
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

variable "namespace" {
  description = "The namespace to deploy Argo CD"
  type        = string
}
