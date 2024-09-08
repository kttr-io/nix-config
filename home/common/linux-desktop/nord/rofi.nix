{ inputs
, lib
, config
, pkgs
, ...
}:
let
  src = pkgs.fetchFromGitHub {
    owner = "undiabler";
    repo = "nord-rofi-theme";
    rev = "8c63231c2e2b41677b08d25753990fb5e047c96c";
    hash = "sha256-zIFDJOmyyFSwWVt1TdjuclHW8PoXG+vzGjzp6C1ejho=";
  };
in
{
  config = {
    programs.rofi = {
      theme = "${src}/nord.rasi";
      extraConfig = {
        show-icons =     true;
      };
    };
  };
}
