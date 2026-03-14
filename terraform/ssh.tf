
# Get the ssh key files from the ssh_keys directory.
# Generate keys with: ./scripts/keygen.sh
locals {
  ssh_key_files = fileset("${path.module}/../ssh_keys", "*.pub")
}

# Create a Hetzner SSH key for each public key file.
resource "hcloud_ssh_key" "team" {
  for_each = toset(local.ssh_key_files)

  name       = trimsuffix(each.value, ".pub")
  public_key = file("${path.module}/../ssh_keys/${each.value}")
}
