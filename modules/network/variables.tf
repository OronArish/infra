variable "env" {
  description = "Deployment environment"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "deploy_single_subnet" {
  description = "If set to true, only one subnet will be deployed."
  type        = bool
}

variable "subnets_cidrs" {
  description = "List of CIDR blocks for the subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags for all resources in the network module."
  type        = map(string)
}
