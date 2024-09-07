{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.sway;
  terminal = config.home.common.linux-desktop.terminal.terminal;

  rofiRbwEnabled = config.home.common.global.bitwarden.enable
    && config.home.common.linux-desktop.rofi.enable;
in
{

  options.home.common.linux-desktop.sway = {
    enable = lib.mkEnableOption "sway module";
    nvidia = lib.mkOption {
      description = "NVIDIA support";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {


    home.common.linux-desktop.waybar.enable = lib.mkDefault true;
    home.common.linux-desktop.rofi.enable = lib.mkDefault true;
    home.common.linux-desktop.swaync.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      unstable.kanshi
    ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      config = {
        modifier = "Mod4";
        inherit terminal;
        menu = "rofi -show drun";

        bars = [{ command = "waybar"; }];

        window.titlebar = false;
      };
    };

    services.kanshi = {
      enable = true;
      package = pkgs.unstable.kanshi;
    };

    xdg.portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-wlr
      ];
      config.sway = {
        default = [ "wlr" "gtk" ];
        "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
      };
    };
  };
}
