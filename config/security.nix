{ config, lib, pkgs, ... }: {
  security = {
    tpm2.enable = true;

    sudo.enable = false;
    doas.enable = true;
  };
}
