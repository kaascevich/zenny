{ config, lib, pkgs, inputs ... }: {
  imports = with inputs; [
    impermanence.homeManagerModules.impermanence
  ];
  home.persistence."/persist/home/kaleb" = {
    directories = [
      "Documents"
      "Photos"
      "Music"
      "Videos"
    ];
  };
}
