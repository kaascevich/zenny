{ config, lib, pkgs, inputs, ... }: {
  modules = [ inputs.impermanence.homeManagerModules.impermanence ];
  home.persistence."/persist/home/kaleb" = {
    directories = [
      "Documents"
      "Photos"
      "Music"
      "Videos"
    ];
  };
}
