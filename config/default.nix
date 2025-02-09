{ config, lib, pkgs, ... }: {
  imports = [
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
  system.stateVersion = "24.11";
}
