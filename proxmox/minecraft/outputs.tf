output "lxc_ipv4" {
  description = "IPv4 address assigned to the Minecraft container."
  value       = local.lxc_ipv4_address
}

output "minecraft_server_endpoint" {
  description = "Endpoint where the Minecraft Java Edition server is expected to listen."
  value       = "${local.lxc_ipv4_address}:${var.minecraft_server_port}"
}
