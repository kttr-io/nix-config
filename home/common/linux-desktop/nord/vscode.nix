{ inputs
, lib
, config
, pkgs
, ...
}:
{
  config = {
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
