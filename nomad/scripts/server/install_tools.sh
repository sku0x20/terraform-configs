#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

install_hashicorp_tools() {
    apt-get update
    apt-get -y install wget gpg coreutils
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt-get update
    apt-get install -y nomad
}

configure_nomad() {
    nomad -autocomplete-install
    complete -C /usr/local/bin/nomad nomad
    useradd --system --home /etc/nomad.d --shell /bin/false nomad
    mkdir --parents /opt/nomad
    chown nomad:nomad /opt/nomad
    wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/nomad/configs/server/nomad.service
    mv nomad.service /etc/systemd/system/nomad.service
    mkdir --parents /etc/nomad.d
    wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/nomad/configs/common/nomad.hcl
    wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/nomad/configs/server/server.hcl
    mv nomad.hcl server.hcl /etc/nomad.d/
}

start_nomad(){
    systemctl enable nomad
    systemctl start nomad
    systemctl status nomad
}

install_hashicorp_tools
configure_nomad
start_nomad