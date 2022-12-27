# HTTP Settings
http_directory = "http"

# Virtual Machine Settings
vm_name                     = "Ubuntu-2204-Template-30GB-Thin"
vm_guest_os_type            = "ubuntu64Guest"
vm_version                  = 14
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 1
vm_cpu_cores                = 4
vm_mem_size                 = 4096
vm_disk_size                = 30720
thin_provision              = true
disk_eagerly_scrub          = false
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "5s"

# ISO Objects
iso_file                    = "ubuntu-22.04.1-live-server-amd64.iso"
iso_checksum                = "10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
iso_checksum_type           = "sha256"
iso_url                     = "https://releases.ubuntu.com/jammy/ubuntu-22.04.1-live-server-amd64.iso" 

# Scripts
shell_scripts               = ["./scripts/setup_ubuntu2204.sh"]

# vSphere Objects
vcenter_insecure_connection     = true
vcenter_server                  = "vcenter.colo.kalinin.xyz"
vcenter_datacenter              = "COLO"
vcenter_host                    = "esx.colo.kalinin.xyz"
vcenter_datastore               = "SSD"
vcenter_network                 = "LAN"
vcenter_folder                  = "Templates"

# ISO Objects
iso_path                        = "[SSD] /packer_cache/ubuntu-22.04.3-live-server-amd64.iso"
