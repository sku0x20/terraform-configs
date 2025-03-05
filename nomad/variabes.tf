variable "name" {
  default = "nomad"
}

variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  default = "ami-00bb0af6826df0a03"
}

variable "key_name" {
  default = "aws-key"
}

// -- server --

variable "server_instance_type" {
  default = "t3.micro"
}

variable "server_count" {
  default = 3
}

variable "server_root_block_device_size" {
  default = 10
}

// -- client --

variable "client_instance_type" {
  default = "t3.micro"
}

variable "client_count" {
  default = 3
}

variable "client_root_block_device_size" {
  default = 10
}
