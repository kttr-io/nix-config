{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.common.linux.graphical-boot;
in
{
  options.common.linux.graphical-boot = {
    enable = lib.mkEnableOption "graphical boot (plymouth)";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      plymouth.enable = true;

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      loader.timeout = 3;
    };

  };
}
