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
      catppuccin = {
        enable = true;
        mode = "createLink";
      };

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;

          modules-left = [
            "hyprland/window"
            "sway/window"
          ];
          modules-center = [
            "hyprland/workspaces"
            "sway/workspaces"
          ];
          modules-right = [
            "hyprland/submap"
            "sway/mode"
            "cpu"
            "pulseaudio"
            "battery"
            "network"
            "custom/swaync"
            "clock"
          ];

          "hyprland/window" = {
            separate-outputs = true;
            icon = true;
            icon-size = 20;
          };

          "sway/window" = {
            separate-outputs = true;
            icon = true;
            icon-size = 20;
          };

          "hyprland/workspaces" = {
            all-outputs = false;
          };

          "sway/workspaces" = {
            all-outputs = false;
          };

          "cpu" = {
            format = "{usage:3}% ";
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
            states = {
              warning = 20;
              critical = 10;
            };
            interval = 10;
            format = "{capacity:3}% {icon}";
            format-icons = [ "" "" "" "" "" ];
            format-full = "{capacity:3}% ";
            format-charging = "{capacity:3}% ";
          };

          "custom/swaync" = {
            "tooltip" = false;
            "format" = "{:>2} {icon}";
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

          "clock" = {
            format = "{:%d. %b.  %H:%M}";
          };
        };
      };

      style = ./style.css;
    };

  };
}
