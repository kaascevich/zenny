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
        ./disks.nix

        lanzaboote.nixosModules.lanzaboote

        impermanence.nixosModules.impermanence
        # impermanence.homeManagerModules.impermanence

        home-manager.nixosModules.home-manager
        # { home-manager = {
        #   useGlobalPkgs = true;
        #   useUserPackages = true;
        #   # users.kaleb = import ./config/home;
        # }; }

        ./config
      ];
    };
  };
}
