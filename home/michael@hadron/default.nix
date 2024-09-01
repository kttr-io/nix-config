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
  home.common.linux-desktop.hyprland.nvidia = true;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      # LG Ultrawide 38"
      "desc:LG Electronics LG ULTRAWIDE 0x00001212, preferred, 0x0, 1"
    ];
  };

}
