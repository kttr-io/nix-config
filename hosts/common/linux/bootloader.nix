{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.common.linux.bootloader;
in
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options = {
    common.linux.bootloader = {
      secureboot = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      sbctl
      efivar
      efibootmgr
    ];

    boot.loader.grub = {
      enable = lib.mkDefault false;

      efiSupport = true;
      efiInstallAsRemovable = true;
    };

    boot.loader.systemd-boot = {
      enable = lib.mkDefault false;
      consoleMode = "auto";
    };

    boot.loader.limine = {
      enable = lib.mkDefault true;
    };

    boot.initrd.systemd = {
      enable = true;
    };
  };
}
