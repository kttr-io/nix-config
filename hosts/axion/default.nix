# Dell XPS 13
{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-13-9370
    ./hardware.nix

    ../common/linux
    ../common/users/michael
  ];

  system.stateVersion = "24.05";
}
