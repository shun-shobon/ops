locals {
  lxc_ipv4_address = split("/", var.ipv4_cidr)[0]
}

resource "proxmox_download_file" "ubuntu_noble_lxc_template" {
  content_type       = "vztmpl"
  datastore_id       = var.template_datastore_id
  node_name          = var.node_name
  file_name          = "ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  url                = "http://download.proxmox.com/images/system/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  checksum           = "45c2978e6b97fe292ada95fe06834276015e5739a594db4de2fdfd830fa0c37942e8ae118fc1e32ffd9154b3f9378b592738b668ea3957db41f2907b86f219de"
  checksum_algorithm = "sha512"
  overwrite          = false
}

resource "proxmox_virtual_environment_container" "alloy" {
  description = "Managed by OpenTofu for an Alloy host container"

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
    template_file_id = proxmox_download_file.ubuntu_noble_lxc_template.id
    type             = "ubuntu"
  }

  tags = [
    "alloy",
    "container",
    "terraform",
  ]

  wait_for_ip {
    ipv4 = true
  }
}
