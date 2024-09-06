{ inputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ./i3-sway.nix
    ./vscode.nix
  ];
}
