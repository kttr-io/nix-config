{ inputs
, lib
, config
, pkgs
, ...
}: {
  services.nix-daemon.enable = lib.mkDefault true;
}

