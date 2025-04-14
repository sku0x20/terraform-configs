

module "network" {
  source = "./network"
  name   = var.name
}

module "runner" {
  source = "./runner"
  name = var.name
  vpc_id = module.network.vpc_id
  subnet_a = module.network.subnet_a
  subnet_public = module.network.subnet_public
  subnet_public_b = module.network.subnet_public_b
}