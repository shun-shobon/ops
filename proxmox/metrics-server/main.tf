data "terraform_remote_state" "alloy" {
  backend = "s3"

  config = {
    bucket                      = "tf-state"
    key                         = "proxmox/alloy/terraform.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}

resource "proxmox_metrics_server" "alloy" {
  name   = var.metrics_server_name
  port   = var.otel_port
  server = data.terraform_remote_state.alloy.outputs.lxc_ipv4
  type   = "opentelemetry"

  opentelemetry_compression         = var.otel_compression
  opentelemetry_headers             = length(var.otel_headers) == 0 ? null : base64encode(jsonencode(var.otel_headers))
  opentelemetry_max_body_size       = var.otel_max_body_size
  opentelemetry_path                = var.otel_path
  opentelemetry_proto               = var.otel_proto
  opentelemetry_resource_attributes = length(var.otel_resource_attributes) == 0 ? null : base64encode(jsonencode(var.otel_resource_attributes))
  opentelemetry_timeout             = var.otel_timeout_seconds
  opentelemetry_verify_ssl          = var.otel_verify_ssl
}
