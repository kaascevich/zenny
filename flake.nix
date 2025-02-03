{
  description = "zenny config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.zenny = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with inputs; [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        impermanence.nixosModules.home-manager
        home-manager.nixosModules.home-manager
        lanzaboote.nixosModules.lanzaboote

        ./disks.nix
        ./config/module.nix
      ];
    };
  };
}
