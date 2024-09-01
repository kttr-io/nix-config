{ inputs
, lib
, config
, pkgs
, ...
}:
let
  pkgs-hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};

  cfg = config.home.common.linux-desktop.hyprland;
  terminal = config.home.common.linux-desktop.terminal.terminal;

  cursor = config.home.pointerCursor.name;
  rofiRbwEnabled = config.home.common.global.bitwarden.enable
    && config.home.common.linux-desktop.rofi.enable;
in
{

  options.home.common.linux-desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland module";
  };

  config = lib.mkIf cfg.enable {

    home.common.linux-desktop.waybar.enable = lib.mkDefault true;
    home.common.linux-desktop.rofi.enable = lib.mkDefault true;
    home.common.linux-desktop.swaync.enable = lib.mkDefault true;

    wayland.windowManager.hyprland.enable = true;
    #    wayland.windowManager.hyprland.package = pkgs-hyprland.hyprland;
    wayland.windowManager.hyprland.settings = {
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

      env = [
        "XCURSOR_THEME,${cursor}"
        "XCURSOR_SIZE,24"
      ];

      exec-once = [
        "waybar"
        "dconf write /org/gnome/desktop/interface/cursor-theme \"'${cursor}'\""
      ];

      bind =
        [
          "SUPER, RETURN, exec, ${terminal}"
          "SUPER, SPACE, exec, rofi -show drun"
          "SUPER SHIFT, SPACE, exec, rofi -show window"

          "SUPER, R, submap, resize"
          "SUPER, ESCAPE, exit,"
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
  };
}
