
// https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config
// https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax

data "cloudinit_config" "server_cloud_config" {
  gzip          = false
  base64_encode = false
  part {
    filename     = "shim.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/scripts/server/shim.sh")
  }

  // write files via cloud-config as multipath doesn't support writting plain files
  // https://cloudinit.readthedocs.io/en/latest/reference/modules.html#write-files
  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content = yamlencode({
      write_files : [
        {
          path : "/run/cloud-data-consul/consul-agent-ca.pem"
          content : file("${path.module}/data/consul-agent-ca.pem")
        },
        {
          path : "/run/cloud-data-consul/dc1-server-consul-0-key.pem"
          content : file("${path.module}/data/dc1-server-consul-0-key.pem")
        },
        {
          path : "/run/cloud-data-consul/dc1-server-consul-0.pem"
          content : file("${path.module}/data/dc1-server-consul-0.pem")
        },
        {
          path : "/run/cloud-data-consul/keygen.txt"
          content : file("${path.module}/data/keygen.txt")
        },
      ]
    })
  }
}

data "cloudinit_config" "client_cloud_config" {
  gzip          = false
  base64_encode = false
  part {
    filename     = "shim.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/scripts/client/shim.sh")
  }

  // write files via cloud-config as multipath doesn't support writting plain files
  // https://cloudinit.readthedocs.io/en/latest/reference/modules.html#write-files
  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content = yamlencode({
      write_files : [
        {
          path : "/run/cloud-data-consul/consul-agent-ca.pem"
          content : file("${path.module}/data/consul-agent-ca.pem")
        },
        {
          path : "/run/cloud-data-consul/keygen.txt"
          content : file("${path.module}/data/keygen.txt")
        },
      ]
    })
  }
}