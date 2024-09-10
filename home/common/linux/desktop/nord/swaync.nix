{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.nord.swaync;
in
{
  options.home.common.linux.desktop.nord.swaync = {
    enable = lib.mkEnableOption "nord theme for swaync";
  };

  config = lib.mkIf cfg.enable {
    services.swaync.style = ./swaync.css;
  };
}
