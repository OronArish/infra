region               = "ap-south-1"
deploy_single_subnet = false
deploy_load_balancer = true
cidr_block           = "10.0.0.0/16"
subnets_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones   = ["ap-south-1a", "ap-south-1b"]
env                  = "staging"
common_tags = {
  Owner           = "Oron.Arish",
  Bootcamp        = "20",
  expiration_date = "10-07-24"
}

# EKS-specific variables
instance_type    = "t3a.large"
desired_capacity = 3
max_capacity     = 4
min_capacity     = 1

# Argocd variables
namespace              = "argocd"
argocd_ssh_secret_name = "ssh-gitlab"
