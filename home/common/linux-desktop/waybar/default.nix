{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.waybar;
in
{
  options.home.common.linux-desktop.waybar = {
    enable = lib.mkEnableOption "Waybar module";
  };


  config = lib.mkIf cfg.enable {

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;

          modules-left = [
            "hyprland/window"
          ];
          modules-center = [
            "hyprland/workspaces"
          ];
          modules-right = [
            "hyprland/submap"
            "hyprland/language"
            "cpu"
            "pulseaudio"
            "battery"
            "network"
            "custom/swaync"
            "clock#date"
            "clock"
          ];

          "hyprland/window" = {
            separate-outputs = true;
            icon = true;
            icon-size = 20;
          };

          "hyprland/workspaces" = {
            all-outputs = false;
          };

          "hyprland/language" = {
            format = "{} ";
            format-en = "en";
            format-de = "de";
          };

          "cpu" = {
            format = "{usage}% ";
          };

          "pulseaudio" = {
            format = "{icon}";
            tooltip-format = "{volume}% - {desc}";
            format-muted = "";
            format-icons = {
              default = [ "" "" "" ];
            };
          };

          "network" = {
            format-wifi = "";
            tooltip-format-wifi = "{essid} ({frequency} GHz, {signalStrength}%)";
            format-ethernet = "";
            tooltip-format-ethernet = "{ifname} ({bandwidthTotalBits})";
            format-disconnected = "";
          };

          "battery" = {
            interval = 10;
            format = "{capacity}% {icon}";
            format-icons = [ "" "" "" "" "" ];
            format-full = "{capacity}% ";
            format-charging = "{capacity}% ";
          };

          "custom/swaync" = {
            "tooltip" = false;
            "format" = "{} {icon}";
            "format-icons" = {
              "notification" = "";
              "none" = "";
              "dnd-notification" = "";
              "dnd-none" = "";
              "inhibited-notification" = "";
              "inhibited-none" = "";
              "dnd-inhibited-notification" = "";
              "dnd-inhibited-none" = "";
            };
            "return-type" = "json";
            "exec-if" = "which swaync-client";
            "exec" = "swaync-client -swb";
            "on-click" = "swaync-client -t -sw";
            "on-click-right" = "swaync-client -d -sw";
            "escape" = true;
          };

          "clock#date" = {
            format = "{:%d. %b.}";
          };
        };
      };

      style = ./style.css;
    };

  };
}
