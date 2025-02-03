{ config, lib, pkgs, ... }: {
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    pulseaudio.enable = true;
    pipewire.enable = false;

    printing.enable = true;
    libinput.enable = true;
  };
}
