#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "must provide one argument (device path to disk to install on)"
  exit 1
fi
diskName="$1"

sudo nix \
  --experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest#disko-install" -- \
  --flake .#zenny --disk main "/dev/$diskName"
