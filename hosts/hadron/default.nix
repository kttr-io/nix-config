# AMD Workstation
{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../common/global
    ./hardware.nix
  ];
}
