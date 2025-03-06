variable "region" {
  default = "ap-south-1"
}

variable "name" {
  default = "test-environment"
}

variable "ami" {
  default = "ami-00bb0af6826df0a03"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "aws-key"
}

variable "root_block_device_size" {
  default = 16
}