# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs:
{
  zen-browser = import ./zen-browser pkgs "specific";
}
