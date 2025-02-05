{ config, lib, pkgs, ... }: {
  programs = {
    nushell.enable = true;
    git.enable = true;
  };
}
