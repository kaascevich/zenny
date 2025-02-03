{ config, lib, pkgs, impermanence, ... }: {
  imports = [ impermanence.homeManagerModules.impermanence ];
  home.persistence."/persist/home/kaleb" = {
    directories = [
      "Documents"
      "Photos"
      "Music"
      "Videos"
    ];
  };
}
