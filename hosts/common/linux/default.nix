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
    ./zram.nix
  ];

  users.users.root.hashedPassword = "!";
}
