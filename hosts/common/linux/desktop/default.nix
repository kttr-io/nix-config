{ inputs
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
    common.linux.graphical-boot.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];

    fonts.packages = with pkgs; [
      font-awesome
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = lib.mkDefault true;
      desktopManager.gnome.enable = lib.mkDefault true;
    };

    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.appimage.binfmt = true;

  };
}
