{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.swaync;
in
{
  options.home.common.linux-desktop.swaync = {
    enable = lib.mkEnableOption "swaync module";
  };

  config = lib.mkIf cfg.enable {

    services.swaync = {
      enable = true;
    };

  };
}
