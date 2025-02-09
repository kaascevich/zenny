#!/usr/bin/env bash

# 64 zeros
zeros=$(printf '0%.0s' {1..64})

doas systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs="0+1+2+3+7+15:sha256=$zeros" \
  /dev/nvme0n1p2
