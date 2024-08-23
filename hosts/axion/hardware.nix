# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
