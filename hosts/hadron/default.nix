# AMD Workstation
{ inputs
, lib
, config
, pkgs
, ...
}:
let
  # We want the latest stuff for Wayland...
  nvidia-560 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "560.35.03";
    # build for latest nvidia-settings is broken
    settingsVersion = "550.54.14";
    sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
    sha256_aarch64 = "sha256-s8ZAVKvRNXpjxRYqM3E5oss5FdqW+tv1qQC2pDjfG+s=";
    openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
    settingsSha256 = "sha256-m2rNASJp0i0Ez2OuqL+JpgEF0Yd8sYVCyrOoo/ln2a4=";
    persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
  };

  pkgs-hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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

  hardware.nvidia.package = nvidia-560;

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  common.linux.bootloader.secureboot = true;
  common.linux.desktop.enable = true;

  disko.devices.disk.main.device = "/dev/nvme1n1";

  environment.systemPackages = with pkgs; [
    egl-wayland
  ];

  hardware.opengl.extraPackages = with pkgs; [
    nvidia-vaapi-driver
  ];

  programs.hyprland = {
    enable = true;

    # Use hyprland unstable, should improve NVIDIA situation
    package = pkgs-unstable.hyprland;

    #This seems to be broken (as of 2024-09-02)
    # portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };


  system.stateVersion = "24.05";
}
