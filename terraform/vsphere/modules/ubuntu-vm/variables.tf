variable "name" {
  nullable = false
  type     = string
}

variable "num_cpus" {
  nullable = false
  default  = 1
  type     = number
}

variable "memory" {
  nullable = false
  type     = number
  default  = 1024
}

variable "disk_size" {
  nullable = false
  type     = number
  default  = 30
}

variable "datacenter" {
  nullable = false
  type = object({
    name = string
    id   = string
  })
}

variable "datastore_id" {
  nullable = false
  type     = string
}
variable "resource_pool_id" {
  nullable = false
  type     = string
}
variable "network_id" {
  nullable = false
  type     = string
}
