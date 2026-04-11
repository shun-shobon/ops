terraform {
  required_version = "1.11.6"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.101.1"
    }
  }

  # https://developers.cloudflare.com/terraform/advanced-topics/remote-backend/#define-r2-backend
  backend "s3" {
    bucket       = "tf-state"
    key          = "proxmox/alloy/terraform.tfstate"
    use_lockfile = true

    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}

provider "proxmox" {
  insecure = true
}
