{ inputs
, lib
, config
, pkgs
, ...
}: {
  zramSwap.enable = lib.mkDefault true;
}
