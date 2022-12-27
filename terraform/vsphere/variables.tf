variable "vsphere_server" {
  description = "vsphere server for the environment - EXAMPLE: vcenter01.hosted.local"
  nullable    = false
  default     = "vcenter.colo.kalinin.xyz"
}

variable "vsphere_user" {
  description = "vsphere server for the environment - EXAMPLE: vsphereuser"
  nullable    = false
  default     = "administrator@vsphere.kalinin.xyz"
}

variable "vsphere_password" {
  description = "vsphere server password for the environment"
  nullable    = false
  sensitive   = true
}
