terraform {
  cloud {
    organization = "kalinin"

    workspaces {
      name = "vsphere"
    }
  }
}
