# This file defines overlays
{ inputs, lib, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  my-packages = final: _prev: import ../pkgs final.pkgs;

  chromium-flags = import ./chromium-flags.nix;
}
