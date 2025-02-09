#!/usr/bin/env bash
set -euo pipefail
if [[ $EUID -ne 0 ]]; then
  echo "must be run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "must provide exactly one argument (/dev name of disk to install on)"
  exit 1
fi
disk="/dev/$1"

if [[ ! -e "$disk" ]]; then
  echo "no disk named $disk"
  exit 1
fi

mount -o remount,size=12G,noatime /nix/.rw-store

nix --experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest#disko-install" -- \
  --option extra-experimental-features "pipe-operators" \
  --flake .#zenny --disk main "$disk"
