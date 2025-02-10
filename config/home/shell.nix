{ config, lib, pkgs, ... }: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      shellAliases = {
        rebuild = "doas nixos-rebuild switch";
      };
    };  

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
      presets = [ "plain-text-symbols" ];
    };
  };
}
