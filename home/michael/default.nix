{ inputs
, lib
, config
, pkgs
, ...
}:
let
  username = "michael";
  homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}";
in
{
  home = {
    inherit username;
    inherit homeDirectory;
  };

  home.packages = with pkgs; [
    nixd
    nixpkgs-fmt
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  home.stateVersion = "24.05";
}
