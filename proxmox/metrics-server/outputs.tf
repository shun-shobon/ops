output "metrics_server_name" {
  description = "Name of the Proxmox metrics server entry."
  value       = proxmox_metrics_server.alloy.name
}

output "otel_http_endpoint" {
  description = "OTLP/HTTP metrics endpoint targeted by Proxmox."
  value       = data.terraform_remote_state.alloy.outputs.otel_http_endpoint
}
