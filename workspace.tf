terraform {
  required_version = ">= 1.1.0"
  backend "remote" {
    organization = "Evilness-ACE"
    workspaces {
      name = "K3S-OCI"
    }
  }
}
