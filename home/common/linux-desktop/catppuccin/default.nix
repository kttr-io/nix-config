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

  config = {
    # FIXME these are deprecated
    #gtk.catppuccin.enable = true;
    #gtk.catppuccin.icon.enable = true;
  };
}
