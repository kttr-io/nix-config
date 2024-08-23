{ inputs
, lib
, config
, pkgs
, ...
}: {
  services.openssh.enable = lib.mkDefault true;
}
