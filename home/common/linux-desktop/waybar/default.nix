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
            "bluetooth"
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
            interval = 3;
            format = "{usage}% ";
          };

          "pulseaudio" = {
            format = "{icon}";
            tooltip-format = "{volume}% - {desc}";
            format-muted = "";
            format-icons = {
              default = [ "" "" "" ];
            };
            on-click-right = "swayosd-client --output-volume mute-toggle";
            on-scroll-up = "swayosd-client --output-volume +5";
            on-scroll-down = "swayosd-client --output-volume -5";
          };

          "network" = {
            format = "";
            format-ethernet = "";
            tooltip-format-wifi = "{essid} ({frequency} GHz, {signalStrength}%)";
            tooltip-format-ethernet = "{ifname} ({bandwidthTotalBits})";
            on-click-right = "rfkill toggle wifi";
          };

          "bluetooth" = {
            format = "";
            format-no-controller = "";
            tooltip-format = "{controller_alias}\t{controller_address}";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            on-click-right = "sleep 1; rfkill toggle bluetooth";
          };

          "battery" = {
            states = {
              warning = 20;
              critical = 10;
            };
            interval = 10;
            format = "{capacity}% {icon}";
            format-icons = [ "" "" "" "" "" ];
            format-full = "{capacity}% ";
            format-charging = "{capacity}% ";
          };

          "custom/swaync" = {
            "tooltip" = false;
            "format" = "{icon}";
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
