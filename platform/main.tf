

module "network" {
  source = "./network"
  name   = var.name
}

module "runner" {
  source = "./runner"
  name = var.name
  vpc_id = module.network.vpc_id
  subnet_id = module.network.subnet_id
}