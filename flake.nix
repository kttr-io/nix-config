{
  description = "kttr-io's Nix Config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nix-darwin
    , home-manager
    , ...
    } @ inputs:
    let
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
      ];

      nixosHosts = [
        "axion"
        "hadron"
        "zino"
      ];

      darwinHosts = [
        "polaron"
      ];

      users = [
        "michael"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      forAllNixosHosts = nixpkgs.lib.genAttrs nixosHosts;
      forAllDarwinHosts = nixpkgs.lib.genAttrs darwinHosts;
      forAllUsers = nixpkgs.lib.genAttrs users;
    in
    {
      # Formatter for your nix files, available through 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = forAllNixosHosts (
        host:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${host}
          ];
        }
      );

      # Nix-Darwin configuration entrypoint
      # Available through 'darwin-rebuild --flake .#your-hostname'
      darwinConfigurations = forAllDarwinHosts (
        host:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${host}
          ];
        }
      );

      packages = forAllSystems (
        system: {
          # Standalone home-manager configuration entrypoint
          # Available through 'home-manager --flake .#your-username'
          homeConfigurations = forAllUsers (
            user: home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.${system};
              extraSpecialArgs = { inherit inputs; };
              modules = [
                ./home/${user}
              ];
            }
          );
        }
      );
    };
}
