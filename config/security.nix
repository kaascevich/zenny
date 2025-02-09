{ config, lib, pkgs, ... }: {
  security = {
    tpm2.enable = true;

    # doas
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }];
    };
  };

  # make `sudo` an alias for `doas`
  environment.systemPackages = [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
  ];
}
