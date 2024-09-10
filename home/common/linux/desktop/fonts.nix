{ inputs
, lib
, config
, pkgs
, ...
}:
let
  nerdfontsFonts = [
    "FiraMono"
    "FiraCode"
    "JetBrainsMono"
  ];

  monospaceFontFamilies = [
    "JetBrainsMono Nerd Font"
    "Font Awesome 6 Free Regular"
    "Font Awesome 6 Brands Regular"
    "Font Awesome 6 Free Solid"
  ];
in
{
  config = {
    home.packages = with pkgs;
      [
        font-awesome
        (nerdfonts.override { fonts = nerdfontsFonts; })
      ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = monospaceFontFamilies;
      };
    };
  };
}
