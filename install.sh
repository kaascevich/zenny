#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko/latest \
  -- --mode destroy,format,mount disks.nix

sudo nixos-install --flake .#zenny
