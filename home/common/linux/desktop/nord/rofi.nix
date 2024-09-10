{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.nord.rofi;

  src = pkgs.fetchFromGitHub {
    owner = "undiabler";
    repo = "nord-rofi-theme";
    rev = "8c63231c2e2b41677b08d25753990fb5e047c96c";
    hash = "sha256-zIFDJOmyyFSwWVt1TdjuclHW8PoXG+vzGjzp6C1ejho=";
  };
in
{
  options.home.common.linux.desktop.nord.rofi = {
    enable = lib.mkEnableOption "nord theme for rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      theme = "${src}/nord.rasi";
      extraConfig = {
        show-icons = true;
      };
    };
  };
}
