variable "metrics_server_name" {
  type        = string
  description = "Name of the Proxmox metrics server entry."
  default     = "alloy"
}

variable "otel_compression" {
  type        = string
  description = "Compression algorithm used by Proxmox OpenTelemetry requests."
  default     = "gzip"
}

variable "otel_headers" {
  type        = map(string)
  description = "Additional HTTP headers added by the Proxmox OpenTelemetry plugin."
  default     = {}
  sensitive   = true
}

variable "otel_max_body_size" {
  type        = number
  description = "Maximum OpenTelemetry request body size in bytes."
  default     = 10000000
}

variable "otel_path" {
  type        = string
  description = "OpenTelemetry HTTP path exposed by Alloy."
  default     = "/v1/metrics"
}

variable "otel_port" {
  type        = number
  description = "OpenTelemetry HTTP port exposed by Alloy."
  default     = 4318
}

variable "otel_proto" {
  type        = string
  description = "Protocol used by the Proxmox OpenTelemetry plugin."
  default     = "http"
}

variable "otel_resource_attributes" {
  type        = map(string)
  description = "Additional resource attributes attached by Proxmox to emitted telemetry."
  default     = {}
}

variable "otel_timeout_seconds" {
  type        = number
  description = "HTTP timeout used by the Proxmox OpenTelemetry plugin."
  default     = 5
}

variable "otel_verify_ssl" {
  type        = bool
  description = "Whether Proxmox verifies SSL certificates for HTTPS OpenTelemetry targets."
  default     = false
}
