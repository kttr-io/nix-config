{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../global
    ./openssh.nix
    ./bootloader.nix
    ./graphical-boot.nix
    ./zram.nix
    ./desktop
  ];

  users.users.root.hashedPassword = "!";
  hardware.enableRedistributableFirmware = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  time.timeZone = lib.mkDefault "Europe/Berlin";

  programs.zsh.enable = true;
  services.pcscd.enable = true;
}
