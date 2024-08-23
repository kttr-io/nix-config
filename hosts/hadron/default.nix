# AMD Workstation
{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../common/linux
    ../common/users/michael
    ./hardware.nix
  ];

  system.stateVersion = "24.05";
}
