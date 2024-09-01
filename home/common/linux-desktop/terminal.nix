{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.terminal;
in
{
  options.home.common.linux-desktop.terminal = {
    terminal = lib.mkOption {
      type = lib.types.enum [
        "alacritty"
        "kitty"
      ];
      default = "alacritty";
    };
  };

  config = {
    programs.alacritty = {
      enable = cfg.terminal == "alacritty";
      settings = {
        window = {
          opacity = 0.7;
          blur = true;
        };
      };
    };

    programs.kitty.enable = cfg.terminal == "kitty";
  };
}
