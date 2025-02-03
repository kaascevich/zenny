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

  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';
}
