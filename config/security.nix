{ config, lib, pkgs, ... }: {
  security = {
    tpm2.enable = true;

    # doas
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{ persist = true; }];
    };
  };
}
