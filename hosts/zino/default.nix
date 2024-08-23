# Virtual Machine for testing
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
