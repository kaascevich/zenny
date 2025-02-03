{ config, lib, pkgs, ... }: {
  home-manager.users.kaleb = { ... }: {
    imports = [
      ./hyprland.nix
      ./persistence.nix
    ];

    programs.home-manager.enable = true;
    home.homeDirectory = "/home/kaleb";
    home.stateVersion = "24.11";
  };
}
