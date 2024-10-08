# Dell XPS 13
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    ../michael
    ../common/linux
  ];

  nixpkgs.overlays = [
    outputs.overlays.chromium-flags.intel
  ];

  # dev tools
  home.common.linux.java.enable = true;
  home.common.global.nodejs.enable = true;

  # desktop
  home.common.linux.desktop.enable = true;
  home.common.linux.desktop.nord.enable = true;

  wayland.windowManager.sway = {
    config = {
      input = {
        # XPS 13 internal Keyboard
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "de(nodeadkeys)";
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
    jetbrains.idea-ultimate
  ];

  services.kanshi.settings = [
    {
      output = {
        # FIXME currently, custom modes don't work with lid-closed/lid-opened
        # https://todo.sr.ht/~emersion/kanshi/80#event-347753
        # https://github.com/swaywm/sway/issues/7868
        criteria = "eDP-1";
        mode = "3840x2160@60Hz";
        scale = 2.5;
        status = "enable";
      };
    }

    ##############################################################
    # Home docked
    ##############################################################
    {
      profile = {
        name = "lid-opened";
        outputs = [
          {
            criteria = "LG Electronics LG ULTRAWIDE 0x00001212";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            # right-bottom of LG Ultrawide
            position = "3840,736";
          }
        ];
      };
    }
    {
      profile = {
        name = "lid-closed";
        outputs = [
          {
            criteria = "LG Electronics LG ULTRAWIDE 0x00001212";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
    }

    ##############################################################
    # Office docked
    ##############################################################
    {
      profile = {
        name = "lid-opened";
        outputs = [
          {
            criteria = "Dell Inc. DELL U2719DC 6Z8J7R2";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            # right-bottom of Dell
            position = "2560,576";
          }
        ];
      };
    }
    {
      profile = {
        name = "lid-closed";
        outputs = [
          {
            criteria = "Dell Inc. DELL U2719DC 6Z8J7R2";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
    }

    ##############################################################
    # Undocked
    ##############################################################
    {
      profile = {
        name = "lid-opened";
        outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
          }
        ];
      };
    }
    {
      profile = {
        name = "lid-closed";
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
    }
  ];
}
