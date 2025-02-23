job "app-2" {
  type = "service"

  meta {
    app-name = "app-2"
  }

  group "app" {
    count = 3

    network {
      port "http" {
        to = 3000
      }
    }

    task "app" {
      driver = "docker"
      config {
        image = "sku0x20/app-1:1"
        ports = ["http"]
      }

      template {
        data        = <<EOH
            APP_NAME={{ env "NOMAD_META_app_name" }}
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