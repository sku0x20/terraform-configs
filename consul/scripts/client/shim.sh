#!/bin/bash

apt-get -y update
apt-get -y install wget
wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/consul/scripts/client/main.sh
chmod +x main.sh
./main.sh