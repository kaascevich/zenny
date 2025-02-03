{ config, lib, pkgs, ... }: {
  networking = {
    useDHCP = lib.mkDefault true;
    
    hostName = "zenny";
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
