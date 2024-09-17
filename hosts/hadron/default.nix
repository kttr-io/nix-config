# AMD Workstation
{ inputs
, lib
, config
, pkgs
, ...
}:
let
  pkgs-wayland = inputs.wayland.packages.${pkgs.stdenv.hostPlatform.system};
in
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

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  common.linux.bootloader.secureboot = true;
  common.linux.desktop.enable = true;
  common.linux.docker.enable = true;

  disko.devices.disk.main.device = "/dev/nvme1n1";

  environment.systemPackages = with pkgs; [
    egl-wayland
  ];

  hardware.graphics.extraPackages = with pkgs; [
    nvidia-vaapi-driver
  ];

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.sway = {
    enable = true;

    extraOptions =
      [
        "--unsupported-gpu"
      ];

    # Use nixpkgs-wayland package, should improve NVIDIA situation
    package = pkgs.sway.override (previous: {
      sway-unwrapped = pkgs-wayland.sway-unwrapped;
    });
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  system.stateVersion = "24.05";
}
