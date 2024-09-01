{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop;
in
{
  options.home.common.linux-desktop = {
    enable = lib.mkEnableOption "Linux desktop module";
  };

  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./terminal.nix
    ./vscode.nix
    ./waybar
    ./rofi
    ./swaync
  ];

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      (brave.override {
        commandLineArgs = [
          "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder"
        ];
      })
      (google-chrome.override {
        commandLineArgs = [
          "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder"
        ];
      })
    ];

    home.common.linux-desktop.gnome.enable = lib.mkDefault true;
    home.common.linux-desktop.hyprland.enable = lib.mkDefault true;

    home.pointerCursor = {
      # This works better for fractional scaling because it includes more sizes (eg. 72x72)
      package = pkgs.apple-cursor;
      name = "macOS-Monterey";
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
