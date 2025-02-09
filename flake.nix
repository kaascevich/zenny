{
  description = "zenny config";

  inputs = let
    dependency = repo: {
      url = "github:${repo}";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  in {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    disko = dependency "nix-community/disko";
    impermanence = dependency "nix-community/impermanence";
    home-manager = dependency "nix-community/home-manager";
    lanzaboote = dependency "nix-community/lanzaboote";
  };

  outputs = { self, nixpkgs, ... }@inputs: with (import ./personal.nix); {
    nixosConfigurations.zenny = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with inputs; [
        disko.nixosModules.disko
        ./disks.nix

        impermanence.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = {
              imports = [ ./config/home ];
            };
          };
        }

        ./config
      ];
    };
  };
}
