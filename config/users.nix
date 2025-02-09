{ config, lib, pkgs, ... }: with (import ../personal.nix); {
  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        description = fullName;
        isNormalUser = true;

        extraGroups = [ "wheel" "networkmanager" ];
        inherit initialHashedPassword;

        shell = pkgs.nushell;
      };
    };
  };
}
