job "app-1" {
  type = "service"

  group "app-1" {
    count = 3

    network {
      port "http" {
        to = 3000
      }
    }

    task "app-1" {
      driver = "docker"
      config {
        image = "sku0x20/app-1:1"
        ports = ["http"]
      }

      template {
        data        = <<EOH
            APP_NAME=app-1
        EOH
        env         = true
        destination = "secrets/.env"
      }

    }

    update {
      max_parallel = 1
    }
  }
}