
# Main application server
resource "hcloud_server" "web" {
  name        = "prod-server-1"
  image       = "ubuntu-24.04"
  server_type = "cx23"

  ssh_keys  = [for k in hcloud_ssh_key.team : k.id]
  user_data = file("${path.module}/cloud-init.yaml")
}
