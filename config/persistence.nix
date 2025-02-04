{ config, lib, pkgs, ... }: {
  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist" = {
      directories = [
        "/etc/nixos"
        "/var/lib/nixos"
      ];
      files = [
        "/etc/machine-id"
        "/etc/secureboot"
      ];
    };
  };
}
