# MacBook Air M1
{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../common/darwin
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
