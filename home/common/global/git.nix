{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.global.git;
in
{
  options.home.common.global.git = {
    userEmail = lib.mkOption {
      type = lib.types.str;
      description = "Git User Email";
    };
    userName = lib.mkOption {
      type = lib.types.str;
      description = "Git User Email";
    };

  };

  config = {
    programs.git = {
      enable = true;
      settings.user = {
        email = cfg.userEmail;
        name = cfg.userName;
      };
    };
  };
}
