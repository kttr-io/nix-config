{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./nix.nix
    inputs.sops-nix.nixosModules.sops
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.my-packages
      outputs.overlays.unstable-packages
    ];
  };
}
