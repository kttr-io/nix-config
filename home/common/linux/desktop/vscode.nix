{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.desktop.vscode;
  monospaceFontFamiliesCSS = lib.strings.concatMapStringsSep "," lib.strings.escapeShellArg config.fonts.fontconfig.defaultFonts.monospace;
in
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        hashicorp.terraform
      ];

      userSettings = {
        editor.fontFamily = monospaceFontFamiliesCSS;
      };
    };
  };
}
