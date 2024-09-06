{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.common.linux.desktop;
in
{
  options.common.linux.desktop = {
    enable = lib.mkEnableOption "basic desktop";
  };

  config = lib.mkIf cfg.enable {

    nixpkgs = {
      overlays = [
        outputs.overlays.chromium-flags
      ];
    };

    common.linux.graphical-boot.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = lib.mkDefault true;
      desktopManager.gnome.enable = lib.mkDefault true;
    };

    services.flatpak.enable = true;

    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.appimage.binfmt = true;
    programs.yubikey-touch-detector.enable = true;
  };
}
