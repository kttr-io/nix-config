{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.gnome;
in
{
  options.home.common.linux-desktop.gnome = {
    enable = lib.mkEnableOption "GNOME module";
  };

  config = lib.mkIf cfg.enable {

    home.common.global.pinentry.package = pkgs.pinentry-gnome3;

    dconf.settings = {
      # enable fractional scaling
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
    };

  };
}
