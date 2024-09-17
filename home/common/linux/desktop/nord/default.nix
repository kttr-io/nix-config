{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.nord;
in
{
  options.home.common.linux.desktop.nord = {
    enable = lib.mkEnableOption "Nord Theme";
  };

  imports = [
    ./alacritty.nix
    ./i3-sway.nix
    ./rofi.nix
    ./swaync.nix
    ./vscode.nix
    ./waybar.nix
  ];

  config = lib.mkIf cfg.enable {

    home.common.linux.desktop.nord = {
      alacritty.enable = lib.mkDefault true;
      i3-sway.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault true;
      swaync.enable = lib.mkDefault true;
      vscode.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
    };

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
