{ config, lib, pkgs, ... }: with (import ../../personal.nix); {
  imports = [
    ./shell.nix
  ];

  programs.home-manager.enable = true;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";
}
