{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../global
    ./bootloader.nix
    ./docker.nix
    ./graphical-boot.nix
    ./openssh.nix
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
