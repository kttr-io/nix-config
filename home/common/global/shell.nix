{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.global.shell;
in
{
  config = {
    programs.bash.enable = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "simple";
      };
    };
  };
}
