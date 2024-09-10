{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  defaultPackage = pkgs.nodejs_22;

  cfg = config.home.common.global.nodejs;
in
{
  options.home.common.global.nodejs = {
    enable = lib.mkEnableOption "NodeJS module";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      defaultPackage
    ];

  };
}
