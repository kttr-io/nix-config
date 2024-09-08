{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.nord.waybar;
in
{
  options.home.common.linux-desktop.nord.waybar = {
    enable = lib.mkEnableOption "nord theme for waybar";
  };

  config = lib.mkIf cfg.enable {
    home.common.linux-desktop.waybar.theme-colors = {
      background = "#2e3440";
      text = "#eceff4";
      urgent = "#ebcb8b";
      warning = "#d08770";
      error = "#bf616a";
    };
  };
}
