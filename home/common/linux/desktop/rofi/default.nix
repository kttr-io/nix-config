{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.rofi;
  bitwardenEnabled = config.home.common.global.bitwarden.enable;
in
{
  options.home.common.linux.desktop.rofi = {
    enable = lib.mkEnableOption "rofi module";
    package = lib.mkOption
      {
        description = "rofi package";
        type = lib.types.package;
        default = pkgs.rofi-wayland;
      };
    rbw.package = lib.mkOption
      {
        description = "rofi-rbw package";
        type = lib.types.package;
        default = pkgs.rofi-rbw-wayland;
      };
  };

  config = lib.mkIf cfg.enable {

    programs.rofi = {
      enable = true;
      package = cfg.package;
    };

    home.packages = lib.optionals (bitwardenEnabled) [
      cfg.rbw.package
    ];
  };
}
