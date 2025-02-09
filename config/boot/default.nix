{ config, lib, pkgs, ... }: {
  imports = [
    ./impermanence.nix
    ./kernel.nix
    ./secure-boot.nix
  ];

  boot.initrd.systemd.enable = true;
}
