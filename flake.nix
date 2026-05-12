{ description = "flODINake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
  let
    system = "x86_64-linux";
    mainUser = "patrick";
    mainUserHome = "/home/${mainUser}";
  in {

    nixosConfigurations.odin = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { 
        inherit inputs mainUser mainUserHome; 
      };

      modules = [
        ./hosts/legion7i/configuration.nix
        ./modules/nixos/steam.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${mainUser} = import ./modules/home/home.nix;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { 
            inherit inputs mainUser mainUserHome;
            secrets = import "${self}/secrets.nix";
          };
        }
        stylix.nixosModules.stylix
      ];
    };

  };
}
