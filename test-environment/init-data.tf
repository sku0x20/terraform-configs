
// https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config
// https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax

# data "cloudinit_config" "my_cloud_config" {
#   gzip          = false
#   base64_encode = false
#   part {
#     filename = "some-data.txt"
#     content_type = ""
#     content = "test"
#   }
# }

