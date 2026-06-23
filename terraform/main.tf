terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone      = "ru-central1-a"
  cloud_id  = "b1g6d73defe449bh9nbb"
  folder_id = "b1gkej995s0hv0o2c7j3"
}

# Динамически ищем самый свежий Container Optimized Image
data "yandex_compute_image" "coi" {
  family = "container-optimized-image"
}

resource "yandex_vpc_network" "network-1" {
  name = "ivan-network"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "ivan-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_instance" "vm-1" {
  name        = "ivan-project-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Подставляем ID найденного свежего образа
      image_id = data.yandex_compute_image.coi.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    docker-compose = <<-EOF
      version: '3'
      services:
        app:
          image: balloonbek/ivan-project:v1
          ports:
            - "80:8000"
          restart: always
    EOF
  }
}

output "external_ip" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}