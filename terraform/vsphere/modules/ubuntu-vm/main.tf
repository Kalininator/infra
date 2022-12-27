data "vsphere_virtual_machine" "template" {
  name          = "/${var.datacenter.name}/vm/Templates/Ubuntu-2204-Template-30GB-Thin"
  datacenter_id = var.datacenter.id
}

locals {
  templatevars = {
    name         = var.name,
    public_key   = "AAAAB3NzaC1yc2EAAAADAQABAAABAQCsZVa2osG9BCD77G2j2hxgrU8jeQDp7AH6UcoC9a4YMYbUZPvRXzLsc1sKvpXh8yRmg0Zm1Gj+cKtOnJ5XgpyX0TWJ6h7RXpv0WnAGCKLP+TqRFZBodG0mKF3MxPCZRnL3jwtuco6hf73RJGw7r4BmUStk1GwvVLoKkDEmaA6JsTG1cHdrastLCBm5z4tVQ9QSptfzIB+E0oic5iSpExFmK7sVe+j7Yk3uGdO26W2h82ajNHDuTC7l85i+bRqXtOfTugHqDlE/zgWEzX6BHus0Zp6h13gDLAHecdzfPwiZtR+kt3+LabJcWI7CwYif59TqszI6IXD9Sae2/oSzXPSx",
    ssh_username = "kal"
  }
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id

  num_cpus             = var.num_cpus
  num_cores_per_socket = 1
  memory               = var.memory
  guest_id             = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = var.network_id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "vm-disk"
    thin_provisioned = true
    eagerly_scrub    = false
    size             = var.disk_size
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("${path.module}/templates/metadata.yaml", local.templatevars))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile("${path.module}/templates/userdata.yaml", local.templatevars))
    "guestinfo.userdata.encoding" = "base64"
  }
  lifecycle {
    ignore_changes = [
      annotation,
      clone[0].template_uuid,
      clone[0].customize[0].dns_server_list,
      clone[0].customize[0].network_interface[0]
    ]
  }
}

output "ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}
