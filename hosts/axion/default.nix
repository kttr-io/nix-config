# Dell XPS 13
{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../common/global
    ../common/users/michael
    ./hardware.nix
  ];
}
