client {
  enabled = true
  server_join {
    retry_join = [ "provider=aws tag_key=nomad-instance-type tag_value=server addr_type=private_v4" ]
  }
}
