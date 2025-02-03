{ config, lib, pkgs, ... }: {
  users = {
    mutableUsers = false;
    users.kaleb = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPasswordFile = ../secrets/password.txt
    };
  };
}
