{ inputs
, lib
, config
, pkgs
, ...
}: {
  nix.package = lib.mkDefault pkgs.nix;
  nix.settings.experimental-features = lib.mkDefault "nix-command flakes";

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;
}
