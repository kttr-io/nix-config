{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../global
    ./openssh.nix
    ./grub.nix
  ];
}
