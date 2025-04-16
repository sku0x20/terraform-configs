

module "server" {
  source = "./server"
  vpc_id = var.vpc_id
  subnet_a = var.subnet_a
  subnet_public = var.subnet_public
  subnet_public_b = var.subnet_public_b
  ami = var.ami
  key_name = var.key_name
  instance_type = var.instance_type
  name = "${var.name}-server"
}


module "client" {
  source = "./client"
  vpc_id = var.vpc_id
  subnet_a = var.subnet_a
  subnet_public = var.subnet_public
  subnet_public_b = var.subnet_public_b
  ami = var.ami
  key_name = var.key_name
  instance_type = var.instance_type
  name = "${var.name}-client"
}
