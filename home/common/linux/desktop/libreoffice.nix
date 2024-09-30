{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.libreoffice;
in
{
   options.home.common.linux.desktop.libreoffice = {
    enable = lib.mkEnableOption "LibreOffice module";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.libreoffice-fresh;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
