#!/usr/bin/env bash
set -euo pipefail
if [[ $EUID -ne 0 ]]; then
  echo "must be run as root"
  exit 1
fi

disk=$(blkid | grep crypto | cut -d ":" -f 1)
systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs="0+2+7+15:sha256=0000000000000000000000000000000000000000000000000000000000000000" \
  "$disk"
