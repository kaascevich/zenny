{ config, lib, pkgs, ... }: {
  imports = [
    ./kernel.nix
    ./plymouth.nix
    ./secure-boot.nix
  ];
}
