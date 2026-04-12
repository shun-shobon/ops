variable "authorized_ssh_keys" {
  type        = list(string)
  description = "SSH public keys installed for the container root user."
  default = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFIiRuHfaDg5uWhVqQV5tuYd+Q2xg+dkt4VHvMmGpxPN YubiKey"
  ]
}

variable "cpu_cores" {
  type        = number
  description = "Number of CPU cores assigned to the container."
  default     = 1
}

variable "dedicated_memory_mb" {
  type        = number
  description = "Dedicated memory assigned to the container in megabytes."
  default     = 1024
}

variable "disk_size_gb" {
  type        = number
  description = "Root filesystem size assigned to the container in gigabytes."
  default     = 8
}

variable "dns_servers" {
  type        = list(string)
  description = "DNS servers configured inside the container."
  default     = ["192.168.0.1", "1.1.1.1"]
}

variable "hostname" {
  type        = string
  description = "Hostname assigned to the container."
  default     = "alloy"
}

variable "ipv4_cidr" {
  type        = string
  description = "Static IPv4 address in CIDR notation assigned to the container."
  default     = "192.168.0.101/24"
}

variable "ipv4_gateway" {
  type        = string
  description = "Default IPv4 gateway configured for the container."
  default     = "192.168.0.1"
}

variable "network_bridge" {
  type        = string
  description = "Proxmox bridge attached to the container network interface."
  default     = "vmbr0"
}

variable "node_name" {
  type        = string
  description = "Proxmox node name where the container is created."
  default     = "pve"
}

variable "rootfs_datastore_id" {
  type        = string
  description = "Datastore ID used for the container root filesystem."
  default     = "local-lvm"
}

variable "swap_memory_mb" {
  type        = number
  description = "Swap memory assigned to the container in megabytes."
  default     = 512
}

variable "template_datastore_id" {
  type        = string
  description = "Datastore ID used to store the Ubuntu LXC template."
  default     = "local"
}

variable "vm_id" {
  type        = number
  description = "VM ID assigned to the Alloy container. If null, the provider auto-assigns one."
  default     = null
  nullable    = true
}
