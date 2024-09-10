{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.common.linux.docker;
in
{
  options.common.linux.docker = {
    enable = lib.mkEnableOption "docker host";
    storageDriver = lib.mkOption {
      type = lib.types.enum [
        "overlay2"
        "btrfs"
      ];
      default = "btrfs";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      storageDriver = cfg.storageDriver;
      rootless = {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          storage-driver = cfg.storageDriver;
        };
      };
    };
  };
}
