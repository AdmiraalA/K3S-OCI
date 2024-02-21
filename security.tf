variable "public_ips" {
  type    = list(string)
  default = ["82.168.9.145/32", "86.85.108.82/32"]
}

resource "oci_core_default_security_list" "default_security_list" {
  compartment_id             = var.compartment_ocid
  manage_default_resource_id = oci_core_vcn.default_oci_core_vcn.default_security_list_id

  display_name = "Default security list"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  dynamic "ingress_security_rules" {
    for_each = var.public_ips
    content {
      protocol    = 1 # ICMP
      source      = ingress_security_rules.value # Use .value instead of .key
      description = "Allow ICMP from ${ingress_security_rules.value}"
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.public_ips
    content {
      protocol    = 6 # TCP (SSH)
      source      = ingress_security_rules.value # Use .value instead of .key
      description = "Allow SSH from ${ingress_security_rules.value}"
      tcp_options {
        min = 22
        max = 22
      }
    }
  }

  ingress_security_rules {
    protocol    = "all"
    source      = var.oci_core_vcn_cidr
    description = "Allow all from VCN subnet"
  }

  freeform_tags = {
    "provisioner"      = "terraform"
    "environment"      = var.environment
    "unique_tag_key"   = var.unique_tag_key   # Fixed variable name
    "unique_tag_value" = var.unique_tag_value # Fixed variable name
  }
}
