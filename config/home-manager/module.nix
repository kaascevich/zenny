{ config, lib, pkgs, ... }: {
  home-manager.users.kaleb = { config, lib, pkgs, ... }: {
    imports = [
      ./hyprland.nix
      ./persistence.nix
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
  };
}
