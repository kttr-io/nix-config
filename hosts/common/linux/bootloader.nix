{ inputs
, lib
, config
, pkgs
, ...
}: {
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
}
