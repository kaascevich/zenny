{ config, lib, pkgs, ... }: with (import ../personal.nix); {
  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        description = fullName;
        isNormalUser = true;

        extraGroups = [
          "wheel"          # for using sudo/doas
          "networkmanager" # for managing network connections
          "tss"            # for managing the TPM
        ];
        inherit initialHashedPassword;

        shell = pkgs.nushell;
      };
    };
  };
}
