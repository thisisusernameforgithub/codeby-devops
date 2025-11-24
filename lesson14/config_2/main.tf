terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone      = "ru-central1-a"
  folder_id = "b1gfj8c3c2rfpss7gco9"
}

resource "yandex_vpc_network" "import_network" {
  name = "import-network"
}

resource "yandex_vpc_subnet" "import_subnet" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.import_network.id
  v4_cidr_blocks = ["10.20.1.0/24"]
}

resource "yandex_compute_instance" "imported_vm" {
  name        = "imported-vm"
  platform_id = "standard-v2"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.import_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
