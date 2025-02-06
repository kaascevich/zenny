{ config, lib, pkgs, ... }: with (import ../../personal.nix); {
  home.persistence."/persist/home/${username}" = {
    allowOther = true;
    directories = [
      "Documents"
      "Downloads"
      "Photos"
      "Music"
      "Videos"
    ];
    files = [
      ".config/nushell/history.txt"
    ];
  };
}
