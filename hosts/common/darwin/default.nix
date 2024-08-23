{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../global
    ./nix-daemon.nix
  ];
}
