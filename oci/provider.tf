terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.64.0"
  }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
}
}
}
provider "oci" {
  # Configuration for Oracle Cloud Infrastructure provider
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key      = var.private_key
  fingerprint      = var.fingerprint
  region           = var.region
}
provider "cloudflare" {
  # Configuration for Cloudflare provider
 api_token = var.cloudflare_api_key
}
