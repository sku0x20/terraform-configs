#!/bin/bash

apt-get -y update
apt-get -y install wget
wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/nomad/scripts/client/install_tools.sh
chmod +x install_tools.sh
./install_tools.sh