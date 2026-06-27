locals {
  lxc_ipv4_address = split("/", var.ipv4_cidr)[0]
}

resource "proxmox_download_file" "ubuntu_resolute_lxc_template" {
  content_type       = "vztmpl"
  datastore_id       = var.template_datastore_id
  node_name          = var.node_name
  file_name          = "ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  url                = "http://download.proxmox.com/images/system/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  checksum           = "d5607f124d01f8ddfebd8e7da34c0022fb2a464e1662ee1e39a13f5ed1bae08a7364c486247fbd9f69f26c710729884ee5047aadb89f33a40066cd5f0d9def88"
  checksum_algorithm = "sha512"
  overwrite          = false
}

resource "proxmox_virtual_environment_container" "minecraft" {
  description = "Managed by OpenTofu for a Minecraft Java Edition server container"

  node_name     = var.node_name
  start_on_boot = true
  unprivileged  = true
  vm_id         = var.vm_id

  cpu {
    cores = var.cpu_cores
  }

  disk {
    datastore_id = var.rootfs_datastore_id
    size         = var.disk_size_gb
  }

  initialization {
    dns {
      servers = var.dns_servers
    }

    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ipv4_cidr
        gateway = var.ipv4_gateway
      }
    }

    user_account {
      keys = var.authorized_ssh_keys
    }
  }

  memory {
    dedicated = var.dedicated_memory_mb
    swap      = var.swap_memory_mb
  }

  network_interface {
    bridge = var.network_bridge
    name   = "veth0"
  }

  operating_system {
    template_file_id = proxmox_download_file.ubuntu_resolute_lxc_template.id
    type             = "ubuntu"
  }

  tags = [
    "container",
    "minecraft",
    "terraform",
  ]

  wait_for_ip {
    ipv4 = true
  }
}
