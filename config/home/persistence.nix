{ config, lib, pkgs, ... }: with ../../personal.nix; {
  home.persistence."/persist/home/${username}" = {
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
