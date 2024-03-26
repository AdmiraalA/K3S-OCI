terraform {
  cloud {
    organization = "Evilness-ACE"

    workspaces {
      name = "K3s-OCI"
    }
  }
}
