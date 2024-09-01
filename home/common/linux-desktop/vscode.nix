{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux-desktop.vscode;
in
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
    ];
    userSettings = {
      window.titleBarStyle = "custom";
      editor.fontFamily = "'Source Code Pro','monospace',monospace,'Font Awesome 6 Free','Font Awesome 6 Free Solid','Font Awesome 6 Brands'";
    };
  };
}
