# Dell XPS 13
{ inputs
, lib
, config
, pkgs
, ...
}:
let
  pkgs-hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ../michael
    ../common/linux-desktop
  ];

  home.common.linux-desktop.enable = true;
  home.common.linux-desktop.hyprland.nvidia = true;
  home.common.linux-desktop.sway.nvidia = true;
  home.common.linux-desktop.nord.enable = true;

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        # LG Ultrawide 38"
        "desc:LG Electronics LG ULTRAWIDE 0x00001212, preferred, 0x0, 1"

        # Dell 27"
        "desc:Dell Inc. DELL U2713H C6F0K43T0P3L, preferred, 640x-1440, 1"

        # VR Goggle or whatever...
        "Unknown-1, disable"
      ];
    };
  };

  home.packages = with pkgs; [
    brave
    firefox
    zen-browser
    pkgs.unstable.jetbrains.idea-ultimate
  ];

  services.kanshi.settings = [
    {
      profile = {
        name = "dualscreen";
        outputs = [
          {
            criteria = "LG Electronics LG ULTRAWIDE 0x00001212";
            position = "0,0";
          }
          {
            criteria = "Dell Inc. DELL U2713H C6F0K43T0P3L";
            # above LG Ultrawide
            position = "640,-1440";
          }
        ];
      };
    }
    {
      profile = {
        name = "single";
        outputs = [
          {
            criteria = "*";
            position = "0,0";
          }
        ];
      };
    }

  ];
}
