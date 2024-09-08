{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.nord;
in
{
  options.home.common.linux-desktop.nord = {
    enable = lib.mkEnableOption "Nord Theme";
  };

  imports = [
    ./alacritty.nix
    ./i3-sway.nix
    ./rofi.nix
    ./vscode.nix
    ./waybar.nix
  ];

  config = lib.mkIf cfg.enable {

    gtk = {
      enable = true;

      theme = {
        package = pkgs.nordic;
        name = "Nordic";
      };

      iconTheme = {
        package = pkgs.papirus-nord;
        name = "Papirus";
      };
    };
  };
}
