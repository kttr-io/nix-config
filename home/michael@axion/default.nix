# Dell XPS 13
{ inputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    ../michael
    ../common/linux-desktop
  ];

  home.common.linux-desktop.enable = true;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      # XPS 13 9370, 4K Screen
      "desc:Sharp Corporation 0x148B, preferred, 0x0, 2.5"
      # LG Ultrawide 38"
      # left of integrated display
      "desc:LG Electronics LG ULTRAWIDE 0x00001212, preferred, auto-left, auto"
    ];

    device = [
      {
        # XPS 13 internal Keyboard
        name = "at-translated-set-2-keyboard";
        kb_layout = "de";
        kb_variant = "basic";
      }
      {
        # XPS 13 touchscreen
        name = "elan24ee:00-04f3:24ee";
        enabled = false;
      }
    ];
  };

  wayland.windowManager.sway = {
    config = {
      # output = {
      #   # XPS 13 9370, 4K Screen
      #   # use 1080p to save some battery...
      #   "Sharp Corporation 0x148B Unknown" = {
      #     scale = "1.25";
      #     mode = "--custom 1920x1080@60Hz";
      #     position = "3840 0";
      #   };
      #   # LG Ultrawide 38"
      #   "LG Electronics LG ULTRAWIDE 0x00001212" = {
      #     scale = "1";
      #     mode = "3840x1600@60Hz";
      #     position = "0 0";
      #   };
      # };

      input = {
        # XPS 13 internal Keyboard
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "de";
        };

        # XPS 13 touchpad
        "1739:30383:DELL07E6:00_06CB:76AF_Touchpad" = {
          tap = "enabled";
        };

        # XPS 13 touchscreen
        "1267:9454:ELAN24EE:00_04F3:24EE" = {
          events = "disabled";
        };
      };
    };
  };

  home.packages = with pkgs; [
    brave
    firefox
    zen-browser
    pkgs.unstable.jetbrains.idea-ultimate
  ];

  catppuccin.enable = true;

  # TODO I don't like the default catppuccin rofi theme 
  programs.rofi.catppuccin.enable = false;
  programs.rofi.theme = "Arc-Dark";

  services.kanshi.settings = [
    {
      profile = {
        name = "undocked";
        outputs = [
          { 
            criteria = "eDP-1"; 
            mode = "--custom 1920x1080@60Hz";
            scale = 1.25;
          }
        ];
      };
    }
    {
      profile = {
        name = "docked-home";
        outputs = [
          { 
            criteria = "LG Electronics LG ULTRAWIDE 0x00001212"; 
            mode = "3840x1600@60Hz";
            position = "0,0";
          }
          { 
            criteria = "eDP-1"; 
            mode = "--custom 1920x1080@60Hz";
            scale = 1.25;
            position = "3840,0";
          }
        ];
      };
    }
  ];
}
