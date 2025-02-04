{ config, lib, pkgs, ... }: {
  services = {
    pulseaudio.enable = true;
    pipewire.enable = false;
  };
}
