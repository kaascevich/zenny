{ config, lib, pkgs, impermanence, ... }: {
  modules = [ impermanence.homeManagerModules.default ];
  home.persistence."/persist/home/kaleb" = {
    directories = [
      "Documents"
      "Photos"
      "Music"
      "Videos"
    ];
  };
}
