
// https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config
// https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax

data "cloudinit_config" "my_cloud_config" {
  gzip          = false
  base64_encode = false
  part {
    filename     = "run_script.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/data/run_script.sh")
  }

  // write files via cloud-config as multipath doesn't support writting plain files
  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content = yamlencode({
      write_files : [
        {
          path : "/tmp/some-data.txt"
          content : file("${path.module}/data/some-data.txt")
        }
      ]
    })
  }
}

