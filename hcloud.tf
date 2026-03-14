

variable "hcloud_token" {}


# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"
}

# get the ssh key files from the ssh_keys directory
# to generate the ssh keys, run the keygen script: ./scripts/keygen.sh
locals {
  ssh_key_files = fileset("${path.module}/ssh_keys", "*.pub")
}

# gets the ssh key files from the ssh_keys directory and creates a new ssh key for each file
resource "hcloud_ssh_key" "team" {
  for_each = toset(local.ssh_key_files)

  name       = trimsuffix(each.value, ".pub")
  public_key = file("${path.module}/ssh_keys/${each.value}")
}

# prod server 1
resource "hcloud_server" "web" {
  name        = "prod-server-1"
  image       = "ubuntu-24.04"
  server_type = "cx23"

  ssh_keys  = [for k in hcloud_ssh_key.team : k.id]
  user_data = file("${path.module}/cloud-init.yaml")
}


output "server_ip" {
  value = hcloud_server.web.ipv4_address
}


resource "hcloud_volume" "storage" {
  name       = "prod-volume-1"
  size       = 50
  server_id  = "${hcloud_server.web.id}"
  automount  = true
  format     = "ext4"
}