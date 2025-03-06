
// -- required --
variable "name" {
}

variable "vpc_id" {
}

variable "subnet_id" {
}
// --

variable "ami" {
  default = "ami-00bb0af6826df0a03"
}

variable "key_name" {
  default = "aws-key"
}

variable "instance_type" {
  default = "t3.micro"
}
