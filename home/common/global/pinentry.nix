{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.global.pinentry;
in
{
  options.home.common.global.pinentry = {
    package = lib.mkOption {
      type = lib.types.package;
      description = "pinentry package";
      default = pkgs.pinentry-tty;
    };
  };
}
