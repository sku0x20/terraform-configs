
variable "project_name" {
}

variable "vpc_id" {
}

variable "subnet_a" {
}

variable "subnet_public" {
}

variable "ami" {
}

variable "key_name" {
}

variable "instance_type" {
}

variable "name" {
  default = "${project_name}-server"
}

variable "root_block_size" {
  default = 10
}
