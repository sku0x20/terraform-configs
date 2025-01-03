packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name                    = "test hashicorp ami{{timestamp}}"
  instance_type               = "t3a.micro"
  region                      = "ap-south-1"
  source_ami                  = "ami-00bb0af6826df0a03"
  associate_public_ip_address = true
  ssh_username                = "ubuntu"
}

build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "file" {
    source = "./data/install-tools.sh"
    destination = "/tmp/install-tools.sh"
  }

  provisioner "shell"{
    inline = ["sudo", "/tmp/install-tools.sh"]  
  }
}