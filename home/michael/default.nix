{ inputs
, lib
, config
, pkgs
, ...
}:
let
  username = "michael";
  username_full = "Michael Kötter";
  email = "michael@m-koetter.de";
in
{
  imports = [
    ../common/global
  ];

  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.common.global.username = username;
  home.common.global.bitwarden.email = email;

  home.common.global.git.userName = username_full;
  home.common.global.git.userEmail = email;

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      bindkey -e
    '';
  };

  home.stateVersion = "24.05";
}
