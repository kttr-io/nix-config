{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.global.bitwarden;
  pinentry = config.home.common.global.pinentry.package;
in
{
  options.home.common.global.bitwarden = {
    enable = lib.mkEnableOption "Bitwarden module";
    email = lib.mkOption {
      type = lib.types.str;
      description = "Bitwarden Email";
    };

  };

  config = lib.mkIf cfg.enable {

    programs.rbw = {
      enable = true;
      settings = {
        inherit (cfg) email;
        inherit pinentry;
      };
    };
  };
}
