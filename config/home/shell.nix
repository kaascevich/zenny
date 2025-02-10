{ config, lib, pkgs, ... }: {
  programs.nushell = {
    enable = true;
    shellAliases = {
      rebuild = "doas nixos-rebuild switch";
    };
  };
}
