{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux;
in
{
  options.home.common.linux = {
    enable = lib.mkEnableOption "Linux module";
  };

  imports = [
    ./java.nix
    ./desktop
  ];

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
    ];

    services.ssh-agent.enable = true;
  };
}
