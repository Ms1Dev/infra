
resource "hcloud_volume" "storage" {
  name      = "prod-volume-1"
  size      = 50
  server_id = hcloud_server.web.id
  automount = true
  format    = "ext4"
}
