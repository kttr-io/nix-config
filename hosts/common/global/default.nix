{ inputs
, lib
, config
, pkgs
, ...
}: {
  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;
}
