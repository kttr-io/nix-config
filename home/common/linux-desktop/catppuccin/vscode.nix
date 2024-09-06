{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.programs.vscode.catppuccin;
in
{
  options = {
    programs.vscode.catppuccin.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enable vscode catppuccin theme";
      default = config.catppuccin.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
      ];

      userSettings = {
        window.titleBarStyle = lib.mkDefault "custom";
        workbench.colorTheme = "Catppuccin Mocha";
        editor.semanticHighlighting.enabled = true;
        terminal.integrated.minimumContrastRatio = 1;
        gopls = {
          ui.semanticTokens = true;
        };
      };
    };
  };
}
