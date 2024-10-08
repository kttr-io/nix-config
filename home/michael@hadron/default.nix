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
    outputs.overlays.chromium-flags.nvidiaWayland
  ];

  # dev tools
  home.common.linux.java.enable = true;
  home.common.global.nodejs.enable = true;
  home.common.global.kubernetes-cli.enable = true;

  # desktop
  home.common.linux.desktop.enable = true;
  home.common.linux.desktop.nord.enable = true;

  # nvidia fixes
  home.common.linux.desktop.sway.nvidia = true;

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    lens
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
