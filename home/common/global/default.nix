{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.global;
  homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${cfg.username}"
    else "/home/${cfg.username}";
in
{
  options.home.common.global = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Username";
    };
  };

  imports = [
    ./shell.nix
    ./git.nix
    ./bitwarden.nix
    ./nodejs.nix
    ./pinentry.nix
    ./kubernetes-cli.nix
  ];

  config = {

    nixpkgs = {
      overlays = [
        outputs.overlays.my-packages
      ];
    };

    home.common.global.bitwarden.enable = lib.mkDefault true;

    nixpkgs.config.allowUnfree = lib.mkDefault true;

    home = {
      inherit (cfg) username;
      inherit homeDirectory;
    };

    home.packages = with pkgs; [
      htop
      nixd
      nixpkgs-fmt
      yubikey-manager
      yubikey-personalization
    ];

    programs.home-manager.enable = true;

    programs.direnv.enable = true;

    programs.neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
    };
  };
}
