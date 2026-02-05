{
  description = "kttr-io's Nix Config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
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

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
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
      inherit (self) outputs;

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

      overlays = import ./overlays { inherit inputs; inherit (nixpkgs) lib; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = forAllNixosHosts (
        host:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
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
          specialArgs = { inherit inputs outputs; };
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
              pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
              extraSpecialArgs = { inherit inputs outputs; };
              modules = [
                ./home/${user}
              ];
            }
          );
        }
        // import ./pkgs (import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        })
      );
    };
}
