{ config, lib, pkgs, ... }: {
  imports = [
    ./kernel.nix
    ./plymouth.nix
    # ./secure-boot.nix
  ];

  # TODO: remove once Lanzaboote is working
  boot.loader.systemd-boot.enable = true;
}
