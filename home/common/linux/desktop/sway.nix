{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.sway;
  terminal = config.home.common.linux.desktop.terminal.terminal;
  pkgs-wayland = inputs.wayland.packages.${pkgs.stdenv.hostPlatform.system};
in
{

  options.home.common.linux.desktop.sway = {
    enable = lib.mkEnableOption "sway module";
    nvidia = lib.mkOption {
      description = "NVIDIA support";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {


    home.common.linux.desktop.waybar.enable = lib.mkDefault true;
    home.common.linux.desktop.rofi.enable = lib.mkDefault true;
    home.common.linux.desktop.swaync.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      kanshi
      wl-mirror
    ];

    wayland.windowManager.sway = {
      enable = true;
      package = null; # use global package
      wrapperFeatures.gtk = true;

      config = rec {
        # Super/Logo key
        modifier = "Mod4";
        inherit terminal;
        menu = "rofi -show drun";

        input."*" = {
          xkb_layout = "us(intl)";
        };

        bars = [{ command = "waybar"; }];

        window.titlebar = false;
        startup = [
          { command = "kanshictl reload"; always = true; }
          { command = "darkman set dark"; }
        ];

        keybindings = lib.mkOptionDefault {
          "${modifier}+p" = "exec rofi-rbw";

          "${modifier}+q" = "kill";

          "${modifier}+Ctrl+Left" = "move container to output left";
          "${modifier}+Ctrl+Right" = "move container to output right";
          "${modifier}+Ctrl+Up" = "move container to output up";
          "${modifier}+Ctrl+Down" = "move container to output down";

          "${modifier}+Alt+Left" = "move workspace to output left";
          "${modifier}+Alt+Right" = "move workspace to output right";
          "${modifier}+Alt+Up" = "move workspace to output up";
          "${modifier}+Alt+Down" = "move workspace to output down";


          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
          "XF86AudioLowerVolume" = "exec  swayosd-client --output-volume lower";
          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
          "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
        };

        floating.criteria = [
          { app_id = "org.gnome.Calculator"; }
          { app_id = "pavucontrol"; }
          { app_id = "yubioath-flutter"; }
          { app_id = "nm-connection-editor"; }
        ];

        window.commands = [

          # Thundebird main window should be normal, while any other Thunderbird windows should be floating
          # assuming the most specific criteria is matched (TODO needs to be verified)
          {
            # This is the main window
            criteria = { app_id = "thunderbird"; title = "^.+ - Mozilla Thunderbird$"; };
            command = "floating disable";
          }
          {
            # These are other windows
            criteria = { app_id = "thunderbird"; };
            command = "floating enable";
          }
        ];
      };

      extraConfig = ''
        bindswitch --locked lid:off exec kanshictl switch lid-opened
        bindswitch --locked lid:on exec kanshictl switch lid-closed
      '';
    };

    services.gnome-keyring.enable = true;

    services.network-manager-applet.enable = true;

    services.kanshi = {
      enable = true;
    };

    services.swayosd.enable = true;

    services.swayidle = {
      enable = true;
      events = [
        { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock"; }
      ];
    };

    programs.swaylock.enable = true;

    programs.wlogout = {
      enable = true;
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
