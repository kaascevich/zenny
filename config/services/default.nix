{ config, lib, pkgs, ... }: {
  imports = [
    ./audio.nix
    ./power.nix
  ];

  services = {
    printing.enable = true;
    libinput.enable = true;
  };
}
