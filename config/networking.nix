{ config, lib, pkgs, ... }: {
  networking = {
    hostName = "zenny";
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
