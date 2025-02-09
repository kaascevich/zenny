{ config, lib, pkgs, ... }: {
  programs.fuse.userAllowOther = true;
  environment.persistence = {
    "/persist" = {
      directories = [
        # Nix stuff
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
