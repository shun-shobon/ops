output "lxc_ipv4" {
  description = "IPv4 address assigned to the Alloy container."
  value       = local.lxc_ipv4_address
}

output "otel_http_endpoint" {
  description = "OTLP/HTTP metrics endpoint expected to be served by Alloy."
  value       = "http://${local.lxc_ipv4_address}:4318/v1/metrics"
}
