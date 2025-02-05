{ config, lib, pkgs, ... }: with (import ../../personal.nix); {
  imports = [
    # ./hyprland.nix
    ./persistence.nix
  ];

  programs.home-manager.enable = true;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";
}
