data "vsphere_datacenter" "colo" {
  name = "COLO"
}

data "vsphere_datastore" "ssd" {
  name          = "SSD"
  datacenter_id = data.vsphere_datacenter.colo.id
}

data "vsphere_host" "colo" {
  name          = "esx.colo.kalinin.xyz"
  datacenter_id = data.vsphere_datacenter.colo.id
}

data "vsphere_network" "lan" {
  name          = "LAN"
  datacenter_id = data.vsphere_datacenter.colo.id
}

module "test-vm" {
  source           = "./modules/ubuntu-vm"
  name             = "vm"
  datacenter       = data.vsphere_datacenter.colo
  datastore_id     = data.vsphere_datastore.ssd.id
  resource_pool_id = data.vsphere_host.colo.resource_pool_id
  network_id       = data.vsphere_network.lan.id
}

output "test-vm-ip" {
  value = module.test-vm.ip
}
