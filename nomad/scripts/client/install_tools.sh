#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


install_docker() {
    apt-get update
    apt-get install -y ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

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
    mkdir --parents /opt/nomad
    wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/nomad/configs/client/nomad.service
    mv nomad.service /etc/systemd/system/nomad.service
    mkdir --parents /etc/nomad.d
    wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/nomad/configs/common/nomad.hcl
    wget https://raw.githubusercontent.com/sku0x20/terraform-configs/refs/heads/main/nomad/configs/client/client.hcl
    mv nomad.hcl client.hcl /etc/nomad.d/
}

start_nomad(){
    systemctl enable nomad
    systemctl start nomad
    systemctl status nomad
}

install_docker
install_hashicorp_tools
configure_nomad
start_nomad