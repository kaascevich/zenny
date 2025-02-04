{ config, lib, pkgs, ... }: {
  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist" = {
      directories = [
        # Nix stuff
        "/etc/nixos"
        "/var/lib/nixos"

        # Wireless connections
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        "/etc/secureboot"
      ];
    };
  };
}
