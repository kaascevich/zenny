{ config, lib, pkgs, ... }: {
  imports = [
    ./audio.nix
    ./hyprland.nix
    ./power.nix
  ];

  services = {
    printing.enable = true;
    libinput.enable = true;
  };
}
