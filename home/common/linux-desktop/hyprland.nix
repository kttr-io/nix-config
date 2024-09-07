{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.hyprland;
  terminal = config.home.common.linux-desktop.terminal.terminal;

  cursor = config.home.pointerCursor.name;

  rofiRbwEnabled = config.home.common.global.bitwarden.enable
    && config.home.common.linux-desktop.rofi.enable;

  # Use nixpkgs-unstable package, should improve NVIDIA situation
  hyprland =
    if cfg.nvidia
    then pkgs.unstable.hyprland
    else pkgs.hyprland;
in
{

  options.home.common.linux-desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland module";
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

    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland;

      settings = {
        source = [
          "submap.conf"
        ];

        monitor = [
          # default for random/unknown monitors
          ",preferred,auto,auto"
        ];

        # default input config
        input = {
          kb_layout = "us,de";
          kb_variant = "intl,basic";
          kb_options = "grp:caps_toggle";
        };

        # to be extended by host specific per-device config...
        device = [ ];

        cursor = {
          no_hardware_cursors = cfg.nvidia;
        };

        env = [
          "XCURSOR_THEME,${cursor}"
          "XCURSOR_SIZE,24"
        ]
        ++ (lib.optionals (cfg.nvidia) [
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct"
        ]);

        exec-once = [
          "waybar"
          "dconf write /org/gnome/desktop/interface/cursor-theme \"'${cursor}'\""
        ];

        bind =
          [
            # Keyboard Binds
            "SUPER, RETURN, exec, ${terminal}"
            "SUPER, SPACE, exec, rofi -show drun"
            "SUPER SHIFT, SPACE, exec, rofi -show window"

            "SUPER, R, submap, resize"

            "SUPER, Q, killactive"
            "SUPER SHIFT, Q, exit,"
          ]
          ++ (lib.optionals (rofiRbwEnabled) [
            "SUPER, P, exec, rofi-rbw"
          ])
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList
              (
                x:
                let
                  ws =
                    let
                      c = (x + 1) / 10;
                    in
                    builtins.toString (x + 1 - (c * 10));
                in
                [
                  "SUPER, ${ws}, workspace, ${toString (x + 1)}"
                  "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
          "SUPER SHIFT, mouse:273, resizewindow 1"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 5;
          resize_on_border = true;
          #extend_border_grab_area = 2;
        };

        decoration = {
          blur = {
            size = 10;
            passes = 3;
          };
        };

        windowrulev2 = [
          # pinentry
          "tag +pinentry, title:^(pinentry-|rbw)"
          "noanim, tag:pinentry"
          "stayfocused, tag:pinentry"
          "dimaround, tag:pinentry"
        ];

        layerrule = [
          #"dimaround, rofi"
          "noanim, rofi"
          #"blur, rofi"
          "blur, waybar"
          "xray 1, waybar"
        ];

        # This seems to fix some flickering in Chromium/Brave etc
        misc.vfr = !cfg.nvidia;

        # debug.disable_logs = false;
      };
    };

    xdg.configFile."hypr/submap.conf".text = ''
      # will start a submap called "resize"
      submap = resize

      # sets repeatable binds for resizing the active window
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10

      # use reset to go back to the global submap
      bind = , escape, submap, reset 

      # will reset the submap, which will return to the global submap
      submap = reset
    '';

    xdg.portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      config.hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
      };
    };

  };
}
