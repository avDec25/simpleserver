terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_container" "simpleserver" {
  image = "simpleserver:latest"
  name  = "simplecontainer"
  ports {
    internal = 8080
    external = 8000
  }
}
