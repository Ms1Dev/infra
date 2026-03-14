#!/usr/bin/env bash
set -euo pipefail

NAME="$(whoami)-$(hostname -s)"

KEY_PATH="${HOME}/.ssh/${NAME}_hetzner_ed25519"
PUB_DEST="$(cd "$(dirname "$0")/.." && pwd)/ssh_keys/${NAME}.pub"

if [ -f "$KEY_PATH" ]; then
  echo "Key already exists: $KEY_PATH"
  exit 1
fi

echo "Generating SSH key for machine: $NAME"

ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -C "${NAME}@hetzner"

cp "${KEY_PATH}.pub" "$PUB_DEST"

echo "Private key stored at: $KEY_PATH"
echo "Public key copied to repo: $PUB_DEST"
