{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    ./global
    ./linux
  ];

  config = {
    home.common.linux.enable = lib.mkDefault pkgs.isLinux;
  };
}
