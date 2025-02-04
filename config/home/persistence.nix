{ config, lib, pkgs, ... }: {
  home.persistence."/persist/home/kaleb" = {
    allowOther = true;
    directories = [
      "Documents"
      "Downloads"
      "Photos"
      "Music"
      "Videos"
    ];
  };
}
