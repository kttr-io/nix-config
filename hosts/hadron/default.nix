# AMD Workstation
{ inputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    ./hardware.nix

    inputs.disko.nixosModules.disko
    ../../disk/btrfs

    ../common/linux
    ../common/users/michael
  ];

  common.linux.bootloader.secureboot = true;
  common.linux.desktop.enable = true;

  disko.devices.disk.main.device = "/dev/nvme1n1";

  environment.systemPackages = with pkgs; [
  ];

  programs.hyprland.enable = true;

  system.stateVersion = "24.05";
}
