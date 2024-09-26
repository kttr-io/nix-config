{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop;
in
{
  options.home.common.linux.desktop = {
    enable = lib.mkEnableOption "Linux desktop module";
  };

  imports = [
    ./fonts.nix
    ./gnome.nix
    ./sway.nix
    ./terminal.nix
    ./vscode.nix
    ./yubikey-touch-detector.nix
    ./waybar
    ./rofi
    ./swaync
    ./nord
  ];

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      brave
      gnome-online-accounts-gtk
      thunderbird
      yubioath-flutter
    ];

    # linux (non-desktop) module should always be enabled too
    home.common.linux.enable = true;

    home.common.linux.desktop.gnome.enable = lib.mkDefault true;
    home.common.linux.desktop.sway.enable = lib.mkDefault true;

    dconf = {
      enable = true;
      settings = {
        # enable fractional scaling
        "org/gnome/mutter" = {
          experimental-features = [ "scale-monitor-framebuffer" ];
        };
      };
    };

    programs.joplin-desktop.enable = true;
    
    # TODO configure thunderbird profiles/accounts
    #programs.thunderbird.enable = true;

    services.darkman = {
      enable = true;
      settings = {
        usegeoclue = false;
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        darkman
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        darkman
      ];
    };

    home.pointerCursor = {
      # This works better for fractional scaling because it includes more sizes (eg. 72x72)
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
