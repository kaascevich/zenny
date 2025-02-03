{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./locale.nix
    ./networking.nix
    ./nixpkgs.nix
    ./packages.nix
    ./persistence.nix
    ./security.nix
    ./users.nix

    ./boot
    ./home
    ./services
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}
