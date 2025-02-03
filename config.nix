{ config, lib, pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "US/Eastern";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.11";
}
