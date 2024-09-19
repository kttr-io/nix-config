{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  defaultPackage = pkgs.nodejs_22;

  cfg = config.home.common.global.kubernetes-cli;
in
{
  options.home.common.global.kubernetes-cli = {
    enable = lib.mkEnableOption "Kubernetes CLI module";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      kubectl
      kubernetes-helm
    ];

  };
}
