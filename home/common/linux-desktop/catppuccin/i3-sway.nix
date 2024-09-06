{ inputs
, lib
, config
, pkgs
, ...
}:
let
  # # target                 title     bg    text   indicator  border
  # client.focused           $lavender $base $text  $rosewater $lavender
  # client.focused_inactive  $overlay0 $base $text  $rosewater $overlay0
  # client.unfocused         $overlay0 $base $text  $rosewater $overlay0
  # client.urgent            $peach    $base $peach $overlay0  $peach
  # client.placeholder       $overlay0 $base $text  $overlay0  $overlay0
  # client.background        $base

  colors = {
    background = "$base";
    focused = {
      background = "$base";
      border = "$lavender";
      childBorder = "$lavender";
      indicator = "$rosewater";
      text = "$text";
    };
    unfocused = {
      background = "$base";
      border = "$overlay0";
      childBorder = "$overlay0";
      indicator = "$rosewater";
      text = "$text";
    };
    focusedInactive = {
      background = "$base";
      border = "$overlay0";
      childBorder = "$overlay0";
      indicator = "$rosewater";
      text = "$text";
    };
    urgent = {
      background = "$base";
      border = "$peach";
      childBorder = "$peach";
      indicator = "$overlay0";
      text = "$peach";
    };
    placeholder = {
      background = "$base";
      border = "$overlay0";
      childBorder = "$overlay0";
      indicator = "$overlay0";
      text = "$text";
    };
  };

  swayCfg = config.wayland.windowManager.sway;
  i3Cfg = config.xsession.windowManager.i3;
in
{
  options = {
    # TODO generate theme file and include in i3 config

    # xsession.windowManager.i3.catppuccin.enable = lib.mkEnableOption {
    #   description = "enable catppuccin theme for i3";
    #   default = config.catppuccin.enable;
    # };
  };

  config = lib.mkIf swayCfg.catppuccin.enable
    {
      wayland.windowManager.sway.config.colors = lib.mkOptionDefault colors;
    };
}
