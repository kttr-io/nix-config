{ inputs
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
    ./git.nix
    ./bitwarden.nix
    ./pinentry.nix
  ];

  config = {

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
    ];

    programs.home-manager.enable = true;
    programs.neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
    };
    
    services.ssh-agent.enable = true;
  };
}
