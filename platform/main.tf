

module "network" {
  source = "./network"
  name   = var.name
}

# module "runner" {
#   source = "./runner"
#   name = var.name
#   vpc_id = module.network.
# }