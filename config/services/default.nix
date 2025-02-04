{ config, lib, pkgs, ... }: {
  imports = [
    ./audio.nix
    ./hyprland.nix
  ];

  services = {
    printing.enable = true;
    libinput.enable = true;
  };
}
