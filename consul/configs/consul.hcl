datacenter = "dc1"
data_dir = "/opt/consul"
retry_join = [ "provider=aws tag_key=consul-instance-type tag_value=server addr_type=private_v4" ]
