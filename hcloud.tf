
variable "hcloud_token" {}


# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"
}


resource "hcloud_server" "web" {
  name        = "prod-server-1"
  image       = "ubuntu-24.04"
  server_type = "cx23"
}