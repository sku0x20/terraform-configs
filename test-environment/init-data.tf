
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
}

