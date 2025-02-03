{ config, lib, pkgs, ... }: {
  home-manager.users.kaleb = {
    programs.home-manager.enable = true;

    home.persistence."/persist/home/kaleb" = {
      directories = [
        "Documents"
        "Photos"
        "Music"
        "Videos"
      ];
      files = [ ];
    };
  };
}
