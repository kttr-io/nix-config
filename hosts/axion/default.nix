# Dell XPS 13
{ inputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-13-9370
    inputs.nixos-hardware.nixosModules.common-hidpi
    ./hardware.nix

    inputs.disko.nixosModules.disko
    ../../disk/luks-btrfs

    ../common/linux
    ../common/users/michael
  ];

  common.linux.bootloader.secureboot = true;
  common.linux.desktop.enable = true;
  common.linux.docker.enable = true;

  disko.devices.disk.main.device = "/dev/nvme0n1";

  hardware.keyboard.qmk.enable = true;
  
  environment.systemPackages = with pkgs; [
    dell-command-configure
  ];

  programs.sway.enable = true;
  programs.light.enable = true;

  console.keyMap = "de";

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  system.stateVersion = "24.05";
}
