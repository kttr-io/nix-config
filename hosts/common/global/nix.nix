{ inputs
, lib
, config
, pkgs
, ...
}: {
  nix.package = lib.mkDefault pkgs.nix;
  nix.settings.experimental-features = lib.mkDefault "nix-command flakes";

  nixpkgs.config.allowUnfree = lib.mkDefault true;
}
