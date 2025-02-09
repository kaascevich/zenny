{ config, lib, pkgs, ... }: {
  boot = {
    # Lanzaboote currently replaces the systemd-boot module. This setting is
    # set to true by default, so we force it to false for now.
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl # for Secure Boot maintenance
  ];
}
