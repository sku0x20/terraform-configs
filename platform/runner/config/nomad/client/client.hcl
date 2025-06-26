client {
  enabled = true
  server_join {
    retry_join = ["provider=aws tag_key=nomad-instance-type tag_value=server addr_type=private_v4"]
  }

  drain_on_shutdown {
    deadline           = "1h"
    force              = false
    ignore_system_jobs = false
  }
}

leave_on_terminate = true
leave_on_interrupt = true
