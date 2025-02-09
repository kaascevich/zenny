#!/usr/bin/env bash
set -euo pipefail
if [[ $EUID -ne 0 ]]; then
  echo "must be run as root"
  exit 1
fi

# 64 zeros
zeros=$(printf '0%.0s' {1..64})

disk=$(blkid | grep crypto | cut -d ":" -f 1)

systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs="0+1+2+3+7+15:sha256=$zeros" \
  "$disk"
