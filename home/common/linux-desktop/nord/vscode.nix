{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.nord.vscode;
in
{
  options.home.common.linux-desktop.nord.vscode = {
    enable = lib.mkEnableOption "nord theme for vscode";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        arcticicestudio.nord-visual-studio-code
      ];

      userSettings = {
        window.titleBarStyle = lib.mkDefault "custom";
        workbench.colorTheme = "Nord";
      };
    };
  };
}
