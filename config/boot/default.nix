{ config, lib, pkgs, ... }: {
  imports = [
    ./impermanence.nix
    ./kernel.nix
    ./secure-boot.nix
  ];

  boot.loader.systemd-boot.enable = true;
}
