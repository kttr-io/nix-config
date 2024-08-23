# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
