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
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
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
        "michael@axion"
        "michael@hadron"
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
            {
              networking.hostName = "${host}";
            }
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
            {
              networking.hostName = "${host}";
            }
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
