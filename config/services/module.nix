{ config, lib, pkgs, ... }: {
  imports = [
    ./hyprland.nix
  ];

  services = {
    pulseaudio.enable = true;
    pipewire.enable = false;

    printing.enable = true;
    libinput.enable = true;
  };
}
