

module "server" {
  source = "./server"
  vpc_id = var.vpc_id
  subnet_a = var.subnet_a
  subnet_public = var.subnet_public
  ami = "ami-00bb0af6826df0a03"
  key_name = "aws-key"
  instance_type = "t3.micro"
  name = "${var.name}-server"
}

