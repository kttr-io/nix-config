{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./nix.nix
    inputs.sops-nix.nixosModules.sops
  ];
}
