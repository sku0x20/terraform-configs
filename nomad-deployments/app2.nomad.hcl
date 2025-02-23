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
        image = "sku0x20/dummy:3"
        ports = ["http"]
      }

      template {
        data        = <<EOH
            APP_NAME={{ env "NOMAD_META_app_name" }}
            {{ range nomadService "app-1" }}
              APP_OTHER={{ .Address }}:{{ .Port }}
            {{ end }}
        EOH
        env         = true
        destination = "local/.env"
      }

      service {
        name     = "app-2"
        port     = "http"
        provider = "nomad"
      }

    }

    update {
      max_parallel = 1
    }
  }
}