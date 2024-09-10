{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.nord.i3-sway;

  extraConfig = ''
    set $nord0 #2E3440
    set $nord1 #3B4252
    set $nord2 #434C5E
    set $nord3 #4C566A
    set $nord4 #D8DEE9
    set $nord5 #E5E9F0
    set $nord6 #ECEFF4
    set $nord7 #8FBCBB
    set $nord8 #88C0D0
    set $nord9 #81A1C1
    set $nord10 #5E81AC
    set $nord11 #BF616A
    set $nord12 #D08770
    set $nord13 #EBCB8B
    set $nord14 #A3BE8C
    set $nord15 #B48EAD

    # target                  title       bg       text     indicator   border
    client.focused            $nord7      $nord2   $nord6   $nord4      $nord7
    client.focused_inactive   $nord2      $nord0   $nord6   $nord4      $nord2
    client.unfocused          $nord2      $nord0   $nord6   $nord4      $nord2
    client.urgent             $nord13     $nord0   $nord13  $nord4      $nord13
    client.placeholder        $nord2      $nord0   $nord6   $nord2      $nord2
    client.background         $nord0
  '';

in
{
  options.home.common.linux.desktop.nord.i3-sway = {
    enable = lib.mkEnableOption "nord theme for i3/sway";
  };

  config = lib.mkIf cfg.enable {
    xsession.windowManager.i3.extraConfig = extraConfig;
    wayland.windowManager.sway.extraConfig = extraConfig;
  };
}
