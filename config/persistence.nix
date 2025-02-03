{ config, lib, pkgs, ... }: {
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
