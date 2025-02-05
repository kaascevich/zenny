#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "must be run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "must provide one argument (device path to disk to install on)"
  exit 1
fi
diskName="$1"

mount -o remount,size=12G,noatime /nix/.rw-store

nix --experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest#disko-install" -- \
  --option extra-experimental-features "pipe-operator" \
  --flake .#zenny --disk main "$diskName"
