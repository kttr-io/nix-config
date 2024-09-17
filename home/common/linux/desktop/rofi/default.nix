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
  };

  config = lib.mkIf cfg.enable {

    programs.rofi = {
      enable = true;
      package = cfg.package;
    };

    home.packages = with pkgs; lib.optionals (bitwardenEnabled) [
      rofi-rbw-wayland
    ];
  };
}
