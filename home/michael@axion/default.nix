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

  home.packages = with pkgs; [
    pkgs.unstable.jetbrains.idea-ultimate
    zen-browser
  ];
}
