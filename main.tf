module "network" {
  source               = "./modules/network"
  cidr_block           = var.cidr_block
  subnets_cidrs        = var.subnets_cidrs
  availability_zones   = var.availability_zones
  common_tags          = var.common_tags
  deploy_single_subnet = var.deploy_single_subnet
  env                  = var.env
}

module "compute" {
  source           = "./modules/compute"
  vpc_id           = module.network.vpc_id
  subnet_ids       = module.network.subnet_ids
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity
  max_capacity     = var.max_capacity
  min_capacity     = var.min_capacity
  common_tags      = var.common_tags
  env              = var.env
}

module "argocd" {
  source                 = "./modules/argocd"
  namespace              = var.namespace
  argocd_ssh_secret_name = var.argocd_ssh_secret_name
}
