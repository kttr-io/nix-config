{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.waybar;

  waybar-yubikey-source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/maximbaz/dotfiles/d64fc9bcd33831585149ac3bb86608ac54d1b5ff/.local/bin/waybar-yubikey";
    hash = "sha256-WUrj1YPHY+MdqVTfFCVSKY7DsvmJ1blcREV2kMBch48=";
  };

  waybar-yubikey = pkgs.writeShellApplication {
    name = "waybar-yubikey";
    runtimeInputs = [ pkgs.bash ];
    text = builtins.readFile waybar-yubikey-source;
    excludeShellChecks = [ "SC2124" "SC2162" ];
  };
in
{
  options.home.common.linux-desktop.waybar = {
    enable = lib.mkEnableOption "Waybar module";
    theme-colors = lib.mkOption {
      description = "color theme for waybar";
      type = lib.types.submodule {
        options = {
          background = lib.mkOption { type = lib.types.str; default = "@theme_bg_color"; };
          text = lib.mkOption { type = lib.types.str; default = "@theme_text_color"; };
          urgent = lib.mkOption { type = lib.types.str; default = "@warning_color"; };
          warning = lib.mkOption { type = lib.types.str; default = "@warning_color"; };
          error = lib.mkOption { type = lib.types.str; default = "@error_color"; };
        };
      };
    };
  };


  config = lib.mkIf cfg.enable {

    home.common.linux-desktop.yubikey-touch-detector = {
      enable = lib.mkDefault true;
      libnotify = lib.mkDefault false;
    };
    

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
            "custom/waybar-yubikey"
            "cpu"
            "pulseaudio"
            "battery"
            "bluetooth"
            "tray"
            "custom/swaync"
            "clock"
            "custom/power"
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

          "custom/waybar-yubikey" = {
            return-type = "json";
            exec = "${waybar-yubikey}/bin/waybar-yubikey";
            escape = true;
          };

          "custom/swaync" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "";
              none = "";
              dnd-notification = "";
              dnd-none = "";
              inhibited-notification = "";
              inhibited-none = "";
              dnd-inhibited-notification = "";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };

          "tray" = {
              icon-size = 20;
              spacing = 10;
          };

          "clock" = {
            format = "{:%d. %b.  %H:%M}";
          };

          "custom/power" = {
              "format" = "⏻";
              "tooltip" = false;
              "on-click" = "wlogout";
          };
        };
      };

      style = ./style.css;
    };

    xdg.configFile."waybar/theme-colors.css".text = ''
      @define-color background ${cfg.theme-colors.background};
      @define-color text ${cfg.theme-colors.text};
      @define-color urgent ${cfg.theme-colors.urgent};
      @define-color warning ${cfg.theme-colors.warning};
      @define-color error ${cfg.theme-colors.error};
    '';

  };
}
