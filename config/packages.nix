{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nushell
    fastfetch
  ];
}
