{ config, lib, pkgs, ... }: {
  programs.kitty.enable = true; # required for default Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

    };
  };
}
