# Dell XPS 13
{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-13-9370
    ./hardware.nix

    inputs.disko.nixosModules.disko
    ../../disk/luks-btrfs

    ../common/linux
    ../common/users/michael
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  zramSwap.enable = lib.mkDefault true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  system.stateVersion = "24.05";
}
