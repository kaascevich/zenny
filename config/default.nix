{ config, lib, pkgs, ... }: {
  imports = [
    ./catppuccin.nix
    ./console.nix
    # ./graphics.nix
    ./hardware.nix
    ./locale.nix
    ./networking.nix
    ./nixpkgs.nix
    ./packages.nix
    ./persistence.nix
    ./programs.nix
    ./security.nix
    ./users.nix

    ./boot
    ./services
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
  environment.etc."nixos/flake.nix".source = "/config/flake.nix";
  system.stateVersion = "24.11";
}
