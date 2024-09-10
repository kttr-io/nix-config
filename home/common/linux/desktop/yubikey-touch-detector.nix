{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.yubikey-touch-detector;
in
{
  options.home.common.linux.desktop.yubikey-touch-detector = {
    enable = lib.mkEnableOption "yubikey-touch-detector module";
    libnotify = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      yubikey-touch-detector
    ];

    systemd.user.services.yubikey-touch-detector = {
      Service = {
        ExecStart = "${pkgs.yubikey-touch-detector}/bin/yubikey-touch-detector";
        Environment = [
          "YUBIKEY_TOUCH_DETECTOR_VERBOSE=false"
          "YUBIKEY_TOUCH_DETECTOR_LIBNOTIFY=${lib.boolToString cfg.libnotify}"
          "YUBIKEY_TOUCH_DETECTOR_STDOUT=true"
          "YUBIKEY_TOUCH_DETECTOR_NOSOCKET=false"
        ];
      };
      Unit = {
        Requires = ["yubikey-touch-detector.socket"];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
        Also = ["yubikey-touch-detector.socket"];
      };
    };

    systemd.user.sockets.yubikey-touch-detector = {
      Socket = {
        ListenStream = "%t/yubikey-touch-detector.socket";
        RemoveOnStop = "yes";
      };
      Install = {
        WantedBy = [ "sockets.target" ];
      };
    };
  };
}
