variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  default = "ami-00bb0af6826df0a03"
}

variable "server_instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "aws-key"
}

variable "server_count" {
  default = 3
}

variable "name" {
  default = "test"
}

variable "root_block_device_size" {
  default = 10
}