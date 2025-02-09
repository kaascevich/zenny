{ config, lib, pkgs, ... }: with (import ../personal.nix); {
  programs.fuse.userAllowOther = true;
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      # Nix stuff
      "/var/lib/nixos"

      # Wireless connections
      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"

      # Secure Boot
      "/etc/secureboot"
      "/var/lib/sbctl"
    ];

    users.${username} = {
      directories = [
        # Everyday stuff
        "Documents"
        "Downloads"
        "Photos"
        "Music"
        "Videos"
      ];
    };
  };
}
