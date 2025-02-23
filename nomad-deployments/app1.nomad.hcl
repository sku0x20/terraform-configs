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
        image = "sku0x20/dummy:3"
        ports = ["http"]
      }

      template {
        data        = <<EOH
            APP_NAME=app-1
            {{ range nomadService "app-2" }}
              server={{ .Address }}:{{ .Port }}
            {{ end }}
        EOH
        env         = true
        destination = "local/.env"
      }

      service {
        name     = "app-1"
        port     = "http"
        provider = "nomad"
      }

    }

    update {
      max_parallel = 1
    }
  }
}