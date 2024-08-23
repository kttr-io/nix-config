# Virtual Machine for testing
{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./hardware.nix

    inputs.disko.nixosModules.disko
    ../../disk/luks-btrfs

    ../common/linux
    ../common/users/michael
  ];

  disko.devices.disk.main.device = "/dev/xvda";

  zramSwap.enable = lib.mkDefault true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  system.stateVersion = "24.05";
}
