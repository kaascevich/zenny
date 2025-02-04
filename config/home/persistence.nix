{ config, lib, pkgs, impermanence, ... }: {
  imports = [ impermanence.homeManagerModules.default ];
  home.persistence."/persist/home/kaleb" = {
    directories = [
      "Documents"
      "Photos"
      "Music"
      "Videos"
    ];
  };
}
