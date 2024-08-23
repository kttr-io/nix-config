# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{ inputs
, config
, lib
, pkgs
, modulesPath
, ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../disk/btrfs
  ];

  disko.devices.disk.main.device = "/dev/xvda";

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "sr_mod" "xen_blkfront" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
