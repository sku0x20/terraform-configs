server {
  enabled          = true
  bootstrap_expect = 3
  server_join {
    retry_join = [ "provider=aws tag_key=nomad-instance-type tag_value=server addr_type=private_v4" ]
  }
}

leave_on_terminate = true
leave_on_interrupt = true